variable "auth_token" {
  type = string
}

variable "project_id" {
  type = string
}

variable "prefix" {
  type    = string
  default = "testbed"
}

variable "operating_system" {
  type    = string
  default = "ubuntu_24_04"
}

variable "plan" {
  type    = string
  default = "c3.small.x86"
}

variable "metro" {
  type    = string
  default = "FR"
}
