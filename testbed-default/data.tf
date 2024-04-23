data "openstack_networking_network_v2" "public" {
  name = var.public
}

resource "terraform_data" "image" {
  # Resource to trigger changes on var.image
  input = var.image
}

data "openstack_images_image_v2" "image" {
  name        = terraform_data.image.output
  most_recent = true
}

resource "terraform_data" "image_node" {
  # Resource to trigger changes on var.image_node
  input = var.image_node
}

data "openstack_images_image_v2" "image_node" {
  name        = terraform_data.image_node.output
  most_recent = true
}
