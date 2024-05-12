# horizon
resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_1" {
  description       = "horizon"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

# horizon
resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_2" {
  description       = "horizon"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

# keystone
resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_3" {
  description       = "keystone"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 5000
  port_range_max    = 5000
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

# magnum
resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_4" {
  description       = "magnum"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 9511
  port_range_max    = 9511
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

# designate
resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_5" {
  description       = "designate"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 9001
  port_range_max    = 9001
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

# glance
resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_6" {
  description       = "glance"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 9292
  port_range_max    = 9292
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

# octavia
resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_7" {
  description       = "octavia"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 9876
  port_range_max    = 9876
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

# swift
resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_8" {
  description       = "swift"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 6780
  port_range_max    = 6780
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

# barbican
resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_9" {
  description       = "barbican"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 9311
  port_range_max    = 9311
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

# ironic
resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_10" {
  description       = "ironic"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 6385
  port_range_max    = 6385
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

# cinder
resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_11" {
  description       = "cinder"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 8776
  port_range_max    = 8776
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

# neutron
resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_12" {
  description       = "neutron"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 9696
  port_range_max    = 9696
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

# nova
resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_13" {
  description       = "nova"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 8774
  port_range_max    = 8774
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

# placement
resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_14" {
  description       = "placement"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 8780
  port_range_max    = 8780
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

# ironic inspector
resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_15" {
  description       = "ironic inspector"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 5050
  port_range_max    = 5050
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}

# novnc
resource "openstack_networking_secgroup_rule_v2" "security_group_management_rule_external_api_16" {
  description       = "novnc"
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  protocol          = "tcp"
  port_range_min    = 6080
  port_range_max    = 6080
  security_group_id = openstack_networking_secgroup_v2.security_group_management.id
}
