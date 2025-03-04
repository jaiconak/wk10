resource "aws_instance" "firstInstance" {
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.webserverSecurity.id]
  ami                    = "ami-02a53b0d62d37a757"
  instance_type          = "t2.micro"
  user_data = file("userData.sh")
  subnet_id = aws_subnet.private1.id
  tags = {
    Name = "Instance-1"
  }
}

resource "aws_instance" "secondInstance" {
  availability_zone      = "us-east-1b"
  vpc_security_group_ids = [aws_security_group.webserverSecurity.id]
  ami                    = "ami-02a53b0d62d37a757"
  instance_type          = "t2.micro"
  user_data = file("userData.sh")
  subnet_id = aws_subnet.private2.id
  tags = {
    Name = "Instance-2"
  }
}