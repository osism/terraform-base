output "node_0_address" {
  value     = openstack_networking_floatingip_v2.node_floating_ip[0].address
  sensitive = true
}

output "node_1_address" {
  value     = openstack_networking_floatingip_v2.node_floating_ip[1].address
  sensitive = true
}

output "node_2_address" {
  value     = openstack_networking_floatingip_v2.node_floating_ip[2].address
  sensitive = true
}

resource "local_file" "NODE_0_ADDRESS" {
  filename        = ".NODE_0_ADDRESS.${var.cloud_provider}"
  file_permission = "0644"
  content         = "NODE_0_ADDRESS=${openstack_networking_floatingip_v2.node_floating_ip[0].address}\n"
}

resource "local_file" "NODE_1_ADDRESS" {
  filename        = ".NODE_1_ADDRESS.${var.cloud_provider}"
  file_permission = "0644"
  content         = "NODE_1_ADDRESS=${openstack_networking_floatingip_v2.node_floating_ip[1].address}\n"
}

resource "local_file" "NODE_2_ADDRESS" {
  filename        = ".NODE_2_ADDRESS.${var.cloud_provider}"
  file_permission = "0644"
  content         = "NODE_2_ADDRESS=${openstack_networking_floatingip_v2.node_floating_ip[2].address}\n"
}

resource "local_file" "inventory" {
  filename        = "inventory.${var.cloud_provider}"
  file_permission = "0644"
  content         = <<-EOT
testbed-node-0 ansible_host=${openstack_networking_floatingip_v2.node_floating_ip[0].address} ansible_user=${var.image_node_user}
testbed-node-1 ansible_host=${openstack_networking_floatingip_v2.node_floating_ip[1].address} ansible_user=${var.image_node_user}
testbed-node-2 ansible_host=${openstack_networking_floatingip_v2.node_floating_ip[2].address} ansible_user=${var.image_node_user}
EOT
}
