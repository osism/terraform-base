resource "null_resource" "node_semaphore" {
  depends_on = [
    openstack_compute_instance_v2.node_server
  ]
}

resource "openstack_compute_instance_v2" "node_server" {
  count             = var.number_of_nodes
  name              = "${var.prefix}-node-${count.index}"
  availability_zone = var.availability_zone
  flavor_name       = var.flavor_node
  key_pair          = openstack_compute_keypair_v2.key.name
  config_drive      = var.enable_config_drive

  depends_on = [
    openstack_networking_router_interface_v2.router_interface
  ]

  network { port = openstack_networking_port_v2.node_port_management[count.index].id }

  user_data = <<-EOT
#cloud-config
network:
   config: disabled
mounts:
  - [ ephemeral0, null ]
ntp:
  enabled: true
  ntp_client: chrony
package_update: true
package_upgrade: true
write_files:
  - content: |
      #!/usr/bin/env bash

      chronyc -a makestep
      touch /var/lib/apt/periodic/update-success-stamp
      echo 'network: {config: disabled}' > /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg
      chown -R ${var.image_node_user}:${var.image_node_user} /home/${var.image_node_user}

      if [[ -e /etc/OTC_region ]]; then
          echo 'GNUTLS_CPUID_OVERRIDE=0x1' >> /etc/environment
      fi
    path: /usr/local/bin/osism-testbed.sh
    permissions: '0755'
runcmd:
  - "/usr/local/bin/osism-testbed.sh"
final_message: "The system is finally up, after $UPTIME seconds"
EOT
}

locals {
  number_of_nodes_with_volumes = var.number_of_nodes <= 3 ? var.number_of_nodes : (var.number_of_nodes - 3)
  first_node_with_volumes = var.number_of_nodes <= 3 ? 0 : 3
  total_volumes = local.number_of_nodes_with_volumes * var.number_of_volumes
}

resource "openstack_blockstorage_volume_v3" "node_volume" {
  count             = local.total_volumes
  name              = "${var.prefix}-volume-${count.index}-node-${(count.index % local.number_of_nodes_with_volumes) + local.first_node_with_volumes}"
  size              = var.volume_size_storage
  availability_zone = var.volume_availability_zone
  volume_type       = var.volume_type
}

resource "openstack_compute_volume_attach_v2" "node_volume_attachment" {
  count       = local.total_volumes
  instance_id = openstack_compute_instance_v2.node_server[(count.index % local.number_of_nodes_with_volumes) + local.first_node_with_volumes].id
  volume_id   = openstack_blockstorage_volume_v3.node_volume[count.index].id
}
