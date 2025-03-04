resource "tls_private_key" "terraform" {
  algorithm = var.tlsAlgo
  rsa_bits  = var.algoBits
}
# Application of Private Key for AWS 1.PUBLIC (ABILITY TO SSH)
resource "aws_key_pair" "publickey" {
  key_name   = var.publicKeyName
  public_key = tls_private_key.terraform.public_key_openssh
}

# Application of Private Key for AWS 1.PRIVATE (GENERATES PEM FILE LOCALLY)
resource "local_file" "privateKey" {
  filename = var.localFileName
  content  = tls_private_key.terraform.private_key_pem
  file_permission = 400
}

