variable "tlsAlgo" {
  description = "TLS Algorithm"
  default = "RSA"
}

variable "algoBits" {
  description = "Number of bits for algo"
  default = 2048
}

variable "publicKeyName" {} #description = "Public Key AWS Side Name" 
variable "localFileName" {} #description = "Local Key Private Side Name" 