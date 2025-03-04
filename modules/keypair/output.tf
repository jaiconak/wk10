output "key_name" {
  value = aws_key_pair.publickey.key_name
}
output "pemKeyName" {
  value =local_file.privateKey.filename
} 