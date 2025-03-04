resource "aws_security_group" "webserverSecurity" {
  name        = "server web"
  vpc_id      = aws_vpc.utcVpc.id
  description = "allow ingress 80"

  ingress {
    description     = "allow ingress 80"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.loadbalancerProxy.id]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

resource "aws_security_group" "loadbalancerProxy" {
  name        = "alb"
  vpc_id      = aws_vpc.utcVpc.id
  description = "allow port 80, 443"
  ingress {
    description = "allow ingress 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow ingress 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}