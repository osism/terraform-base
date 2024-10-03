output "public_key" {
  value = tls_private_key.key.public_key_openssh
}

output "private_key" {
  value     = tls_private_key.key.private_key_openssh
  sensitive = true
}

resource "local_sensitive_file" "id_rsa" {
  filename        = ".id_rsa.equinix_metal"
  file_permission = "0600"
  content         = tls_private_key.key.private_key_openssh
}

resource "local_file" "id_rsa_pub" {
  filename        = ".id_rsa.equinix_metal.pub"
  file_permission = "0644"
  content         = "${tls_private_key.key.public_key_openssh}\n"
}
