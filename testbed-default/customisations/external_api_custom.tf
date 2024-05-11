resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 5000
  port_range_max    = 5000
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}
