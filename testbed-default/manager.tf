resource "openstack_networking_port_v2" "manager_port_management" {
  network_id = openstack_networking_network_v2.net_management.id
  security_group_ids = [
    openstack_networking_secgroup_v2.security_group_management.id
  ]

  fixed_ip {
    ip_address = "192.168.16.5"
    subnet_id  = openstack_networking_subnet_v2.subnet_management.id
  }

  allowed_address_pairs {
    ip_address = "192.168.16.8/20"
  }

  allowed_address_pairs {
    ip_address = "192.168.112.0/20"
  }
}

resource "openstack_blockstorage_volume_v3" "manager_base_volume" {
  count             = 0
  image_id          = data.openstack_images_image_v2.image.id
  name              = "${var.prefix}-volume-manager-base"
  size              = var.volume_size_base
  availability_zone = var.volume_availability_zone
  volume_type       = var.volume_type

  lifecycle {
    ignore_changes = [
      # When specifying images by name, their ID might change when they
      # are updated.
      # Replacing the whole environment in this case is probably not
      # what is expected by the user
      image_id,
    ]
    replace_triggered_by = [
      # Explicitly changing the image should trigger recreation
      terraform_data.image
    ]
  }
}

resource "openstack_compute_instance_v2" "manager_server" {
  name              = "${var.prefix}-manager"
  availability_zone = var.availability_zone
  flavor_name       = var.flavor_manager
  key_pair          = openstack_compute_keypair_v2.key.name
  config_drive      = var.enable_config_drive

  depends_on = [
    null_resource.node_semaphore
  ]

  lifecycle {
    ignore_changes = [
      # When specifying images by name, their ID might change when they
      # are updated.
      # Replacing the whole environment in this case is probably not
      # what is expected by the user
      image_id,
    ]
    replace_triggered_by = [
      terraform_data.image
    ]
  }

  network { port = openstack_networking_port_v2.manager_port_management.id }

  user_data = <<-EOT
#cloud-config
network:
   config: disabled
ntp:
  enabled: true
  ntp_client: chrony
package_update: true
package_upgrade: false
write_files:
  - content: |
      #!/usr/bin/env bash

      chronyc -a makestep
      touch /var/lib/apt/periodic/update-success-stamp
      echo 'network: {config: disabled}' > /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg
      chown -R ubuntu:ubuntu /home/ubuntu

      if [[ -e /etc/OTC_region ]]; then
          echo 'GNUTLS_CPUID_OVERRIDE=0x1' >> /etc/environment
      fi
    path: /usr/local/bin/osism-testbed.sh
    permissions: '0755'
  - content: ${openstack_compute_keypair_v2.key.public_key}
    path: /home/ubuntu/.ssh/id_rsa.pub
    permissions: '0600'
  - content: |
      ${indent(6, openstack_compute_keypair_v2.key.private_key)}
    path: /home/ubuntu/.ssh/id_rsa
    permissions: '0600'
  - content: |
      export NUMBER_OF_NODES=${var.number_of_nodes}

      export CEPH_VERSION=${var.ceph_version}
      export CONFIGURATION_VERSION=${var.configuration_version}
      export MANAGER_VERSION=${var.manager_version}
      export OPENSTACK_VERSION=${var.openstack_version}

      export REFSTACK=${var.refstack}
      export TEMPEST=${var.tempest}
      export IS_ZUUL=${var.is_zuul}

    path: /opt/manager-vars.sh
    permissions: '0644'
runcmd:
  - "/usr/local/bin/osism-testbed.sh"
final_message: "The system is finally up, after $UPTIME seconds"
EOT

}
