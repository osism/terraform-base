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
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.security_group_node.id
}

resource "openstack_networking_secgroup_rule_v2" "security_group_node_rule2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.security_group_node.id
}

resource "openstack_networking_secgroup_rule_v2" "security_group_node_rule3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.security_group_node.id
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

  allocation_pool {
    start = "192.168.31.200"
    end   = "192.168.31.250"
  }
}
