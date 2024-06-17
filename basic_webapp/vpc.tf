resource "aws_vpc" "webapp_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    name = "dev"
  }
}

# This is to make the vpc connect to the internet
resource "aws_internet_gateway" "webapp_igw" {
  vpc_id = aws_vpc.webapp_vpc.id
  tags = {
    name = "dev"
  }
}

# This is to create a route table for the vpc on how traffic 
# should be routed to the internet and gateway
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.webapp_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.webapp_igw.id
}
}

# Here we are associating the route table to the subnet in the vpc
resource "aws_route_table_association" "route_table_association1" {
  subnet_id      = aws_subnet.webapp_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "route_table_association2" {
  subnet_id      = aws_subnet.webapp_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnet" "webapp_subnet1" {
  vpc_id                  = aws_vpc.webapp_vpc.id
  cidr_block              = "10.123.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "webapp_subnet2" {
  vpc_id                  = aws_vpc.webapp_vpc.id
  cidr_block              = "10.123.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}