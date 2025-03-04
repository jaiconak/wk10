variable "key_algorithm" {
  description = "This is the key algorithm"
  default =  "RSA"
}
variable "rsa_bits_size" {
  description = "rsa bits size"
  default = 2048
}
variable "keyName" {} #Needs to be initialized

variable "pemFileName" {} #Needs to be initialized

variable "pemFilePermission" {
  default = 400
}