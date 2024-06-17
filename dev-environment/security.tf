resource "aws_security_group" "dev_sg" {
    vpc_id = aws_vpc.vpc1.id
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["99.230.133.75/32"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_key_pair" "mykey" {
  key_name   = "aws_key"
  public_key = file("~/.ssh/aws_key.pub")
  
}


