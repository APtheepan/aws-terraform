
resource "aws_instance" "webapp-ec2-1" {
  ami                    = data.aws_ami.server_ami.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.webapp-key.key_name
  subnet_id              = aws_subnet.webapp_subnet1.id
  vpc_security_group_ids = [aws_security_group.webapp_sg.id]
  user_data       = <<-EOF
              #!/bin/bash
              echo "Hello, World 1" > index.html
              python3 -m http.server 8080 &
              EOF
  tags = {
    Name = "dev"
  }
}

resource "aws_instance" "webapp-ec2-2" {
  ami                    = data.aws_ami.server_ami.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.webapp-key.key_name
  subnet_id              = aws_subnet.webapp_subnet2.id
  vpc_security_group_ids = [aws_security_group.webapp_sg.id]
  user_data       = <<-EOF
              #!/bin/bash
              echo "Hello, World 2" > index.html
              python3 -m http.server 8080 &
              EOF

  tags = {
    Name = "dev"
  }
}