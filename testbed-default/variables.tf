variable "cloud_provider" {
  type = string
}

variable "prefix" {
  type    = string
  default = "testbed"
}

variable "keypair" {
  type    = string
  default = "testbed"
}

variable "image" {
  type    = string
  default = "Ubuntu 24.04"
}

variable "image_user" {
  type    = string
  default = "ubuntu"
}

variable "image_node" {
  type    = string
  default = "Ubuntu 24.04"
}

variable "image_node_user" {
  type    = string
  default = "ubuntu"
}

variable "volume_size_base" {
  type    = number
  default = 80
}

variable "volume_size_storage" {
  type    = number
  default = 20
}

variable "volume_type" {
  type    = string
  default = null
}

variable "flavor_node" {
  type    = string
  default = "SCS-8V-32-50"
}

variable "flavor_manager" {
  type    = string
  default = "SCS-4V-8-50"
}

variable "availability_zone" {
  type    = string
  default = "nova"
}

variable "volume_availability_zone" {
  type    = string
  default = "nova"
}

variable "network_availability_zone" {
  type    = string
  default = "nova"
}

variable "public" {
  type    = string
  default = "external"
}

variable "ara" {
  type    = bool
  default = true
}

variable "tempest" {
  type    = bool
  default = false
}

variable "configuration_version" {
  type    = string
  default = "main"
}

variable "ceph_version" {
  type    = string
  default = "quincy"
}

variable "manager_version" {
  type    = string
  default = "latest"
}

variable "openstack_version" {
  type    = string
  default = "2023.2"
}

variable "number_of_nodes" {
  type    = number
  default = 6
}

variable "number_of_volumes" {
  type    = number
  default = 3
}

variable "enable_config_drive" {
  type    = bool
  default = true
}

variable "dns_nameservers" {
  type    = list(string)
  default = ["8.8.8.8", "9.9.9.9"]
}

variable "is_zuul" {
  type    = bool
  default = false
}

variable "external_api" {
  type    = bool
  default = false
}

variable "ceph_stack" {
  type    = string
  default = "ceph-ansible"
  validation {
    condition = (
      can(regex("^(ceph-ansible|rook)$", var.ceph_stack))
    )
    error_message = "Invalid Ceph Stack provided. Options: ceph-ansible|rook"
  }
}
