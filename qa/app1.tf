provider "aws" {
  region = "us-east-1"
  profile = "default"
}

module "qaTest" {
  source = "../keypair-module"
  localFileName = "publicKey.pem"
  publicKeyName = "publicKey"
  }