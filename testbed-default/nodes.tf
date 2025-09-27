resource "openstack_networking_port_v2" "node_port_management" {
  count              = var.number_of_nodes
  network_id         = openstack_networking_network_v2.net_management.id
  security_group_ids = [openstack_networking_secgroup_v2.security_group_node.id]

  fixed_ip {
    ip_address = "192.168.16.1${count.index}"
    subnet_id  = openstack_networking_subnet_v2.subnet_management.id
  }

  allowed_address_pairs {
    ip_address = "192.168.16.8/32"
  }

  allowed_address_pairs {
    ip_address = "192.168.16.9/32"
  }

  allowed_address_pairs {
    ip_address = "192.168.16.254/32"
  }
}

resource "openstack_blockstorage_volume_v3" "node_base_volume" {
  image_id          = data.openstack_images_image_v2.image_node.id
  count             = 0
  name              = "${var.prefix}-volume-${count.index}-node-base"
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
      terraform_data.image_node
    ]
  }
}
