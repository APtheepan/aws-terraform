resource "aws_vpc" "vpc1" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    name = "dev"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.123.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    name = "dev_public"
  }
}
# This will help to connect the VPC to the internet
resource "aws_internet_gateway" "vpc_internet_gateway" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    name = "dev"
  }
}

# Define the route between the VPC and the internet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    name = "dev_rt"
  }
}
resource "aws_route" "defoult_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0" # Means all the ip addresses will get to this gateway
  gateway_id             = aws_internet_gateway.vpc_internet_gateway.id

}

resource "aws_route_table_association" "public_suassociate" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}


