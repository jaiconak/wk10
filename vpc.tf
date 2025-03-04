resource "aws_vpc" "utcVpc" {
  cidr_block           = "172.120.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "utc-app1"
    Team        = "wdp"
    Environment = "dev"
    Created-by  = "Jaico"
  }
}
# Internet Gateway
resource "aws_internet_gateway" "utcInternetGateway" { #INTERNET GATEWAY
  vpc_id = aws_vpc.utcVpc.id
  tags = {
    Name = "dev-wdp-IGW"
  }
}

# Public Subnet 1
resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.utcVpc.id
  cidr_block              = "172.120.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}
# Public Subnet 2
resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.utcVpc.id
  cidr_block              = "172.120.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

# Private Subnet 1
resource "aws_subnet" "private1" {
  vpc_id                  = aws_vpc.utcVpc.id
  cidr_block              = "172.120.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}
# Private Subnet 2
resource "aws_subnet" "private2" {
  vpc_id                  = aws_vpc.utcVpc.id
  cidr_block              = "172.120.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

# Generates Elastic IP for use
resource "aws_eip" "eip" {}

# NAT gateway - Communicate to the internet
resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public1.id
}

# Private Route Table (Routes Traffic inside the private Subnet )
resource "aws_route_table" "privateRouteTable" {
  vpc_id = aws_vpc.utcVpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat1.id
  }
}

# Public Route Table (Routes Traffic inside the public Subnet )
resource "aws_route_table" "publicRouteTable" {
  vpc_id = aws_vpc.utcVpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.utcInternetGateway.id
  }
}

# Pub Route Table Association 1
resource "aws_route_table_association" "pubRoute1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.publicRouteTable.id
}
# Pub Route Table Association 2
resource "aws_route_table_association" "pubRoute2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.publicRouteTable.id
}

# Private Route Table Association 1
resource "aws_route_table_association" "prvRoute1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.privateRouteTable.id
}
# Private Route Table Association 2
resource "aws_route_table_association" "prvRoute2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.privateRouteTable.id
}