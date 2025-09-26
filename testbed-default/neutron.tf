###################
# Security groups #
###################

resource "openstack_networking_secgroup_v2" "security_group_node" {
  name        = "${var.prefix}-node"
  description = "node security group"
  depends_on  = [openstack_networking_router_v2.router]
}

resource "openstack_networking_secgroup_rule_v2" "security_group_node_rule1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  security_group_id = openstack_networking_secgroup_v2.security_group_node.id
}

resource "openstack_networking_secgroup_rule_v2" "security_group_node_rule2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "udp"
  security_group_id = openstack_networking_secgroup_v2.security_group_node.id
}

resource "openstack_networking_secgroup_rule_v2" "security_group_node_rule3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "icmp"
  security_group_id = openstack_networking_secgroup_v2.security_group_node.id
}

resource "openstack_networking_secgroup_v2" "security_group_management" {
  name        = "${var.prefix}-management"
  description = "management security group"
  depends_on  = [openstack_networking_router_v2.router]
}

resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule1" {
  description       = "ssh"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule2" {
  description       = "wireguard"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "udp"
  port_range_min    = 51820
  port_range_max    = 51820
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "192.168.16.0/20"
  protocol          = "tcp"
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule4" {
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "192.168.16.0/20"
  protocol          = "udp"
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule5" {
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "icmp"
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

resource "openstack_networking_secgroup_rule_v2" "security_group_rule_vrrp" {
  description       = "vrrp"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "112" # vrrp
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.security_group_node.id
}

############
# Networks #
############

resource "openstack_networking_network_v2" "net_management" {
  name = "net-${var.prefix}-management"
}

resource "openstack_networking_subnet_v2" "subnet_management" {
  name            = "subnet-${var.prefix}-management"
  network_id      = openstack_networking_network_v2.net_management.id
  cidr            = "192.168.16.0/20"
  ip_version      = 4
  dns_nameservers = var.dns_nameservers
}
