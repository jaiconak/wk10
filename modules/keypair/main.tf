resource "tls_private_key" "terraform" {
  algorithm = var.key_algorithm
  rsa_bits  = var.rsa_bits_size
}
# Application of Private Key for AWS 1.PUBLIC (ABILITY TO SSH)
resource "aws_key_pair" "publickey" {
  key_name   = var.keyName
  public_key = tls_private_key.terraform.public_key_openssh
}

# Application of Private Key for AWS 1.PRIVATE (GENERATES PEM FILE LOCALLY)
resource "local_file" "privateKey" {
  filename = var.pemFileName
  content  = tls_private_key.terraform.private_key_pem
  file_permission = var.pemFilePermission
}

