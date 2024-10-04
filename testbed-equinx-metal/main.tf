terraform {
  required_version = ">= 1.6.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">= 2.2"
    }

    null = {
      source = "hashicorp/null"
    }

    equinix = {
      source  = "equinix/equinix"
      version = ">= 2.6.0"
    }
  }
}

provider "equinix" {
  auth_token = var.auth_token
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "equinix_metal_ssh_key" "key" {
  name       = "${var.prefix}-key"
  public_key = tls_private_key.key.public_key_openssh
}

resource "equinix_metal_vlan" "net_management" {
  metro       = var.metro
  project_id  = var.project_id
  vxlan       = 100
  description = "Management / Internal"
}

resource "equinix_metal_device" "node0" {
  hostname         = "${var.prefix}-node-0"
  plan             = var.plan
  metro            = var.metro
  operating_system = var.operating_system
  billing_cycle    = "hourly"
  project_id       = var.project_id
  depends_on       = [equinix_metal_ssh_key.key, equinix_metal_vlan.net_management]

  ip_address {
    type = "public_ipv4"
  }
}

resource "equinix_metal_port" "port" {
  port_id    = [for p in equinix_metal_device.node0.ports : p.id if p.name == "bond0"][0]
  layer2     = false
  bonded     = true
  vlan_ids   = [equinix_metal_vlan.net_management.id]
  depends_on = [equinix_metal_device.node0]
}
