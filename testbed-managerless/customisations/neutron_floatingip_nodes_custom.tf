resource "openstack_networking_floatingip_v2" "node_floating_ip" {
  count      = var.number_of_nodes
  pool       = var.public
  depends_on = [openstack_networking_router_interface_v2.router_interface]
}

resource "openstack_networking_floatingip_associate_v2" "node_floating_ip_association" {
  count       = var.number_of_nodes
  floating_ip = openstack_networking_floatingip_v2.node_floating_ip[count.index].address
  port_id     = openstack_networking_port_v2.node_port_management[count.index].id
}

resource "openstack_networking_router_v2" "router" {
  name                = var.prefix
  external_network_id = data.openstack_networking_network_v2.public.id
  depends_on          = [openstack_networking_subnet_v2.subnet_management]
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet_management.id
}
