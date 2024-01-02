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

      if [[ -e /etc/osism-ci-image ]]; then
          # import ceph-daemon images
          for image in $(find /opt/images/node -maxdepth 1 -mindepth 1 -name "*ceph-daemon*"); do
              sudo -u dragon skopeo copy dir:$image docker-daemon:osism.harbor.regio.digital/osism/$(basename $image)
              sudo -u dragon docker pull osism.harbor.regio.digital/osism/$(basename $image)
          done

          # import all other images
          for image in $(find /opt/images/node -maxdepth 1 -mindepth 1 -not -name "*ceph-daemon*"); do
              sudo -u dragon skopeo copy dir:$image docker-daemon:osism.harbor.regio.digital/kolla/release/$(basename $image)
              sudo -u dragon docker pull osism.harbor.regio.digital/kolla/release/$(basename $image)
          done
      fi

    path: /usr/local/bin/osism-testbed-import-images.sh
    permissions: '0755'
  - content: |
      #!/usr/bin/env bash

      chronyc -a makestep
      touch /var/lib/apt/periodic/update-success-stamp
      echo 'network: {config: disabled}' > /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg
      chown -R ubuntu:ubuntu /home/ubuntu

      /usr/local/bin/osism-testbed-import-images.sh &>/dev/null & disown

    path: /usr/local/bin/osism-testbed.sh
    permissions: '0755'
runcmd:
  - "/usr/local/bin/osism-testbed.sh"
final_message: "The system is finally up, after $UPTIME seconds"
EOT
}

resource "openstack_compute_volume_attach_v2" "node_volume_attachment" {
  count       = var.number_of_nodes * var.number_of_volumes
  instance_id = openstack_compute_instance_v2.node_server[count.index % var.number_of_nodes].id
  volume_id   = openstack_blockstorage_volume_v3.node_volume[count.index].id
}

resource "openstack_blockstorage_volume_v3" "node_volume" {
  count             = var.number_of_nodes * var.number_of_volumes
  name              = "${var.prefix}-volume-${count.index}-node-${count.index % var.number_of_nodes}"
  size              = var.volume_size_storage
  availability_zone = var.volume_availability_zone
  volume_type       = var.volume_type
}
