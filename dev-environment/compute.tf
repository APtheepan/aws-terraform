resource "aws_instance" "dev_ec2" {
    ami           = data.aws_ami.server_ami.id
    instance_type = "t2.micro"
    key_name      = aws_key_pair.mykey.id
    vpc_security_group_ids = [aws_security_group.dev_sg.id]
    subnet_id     = aws_subnet.public_subnet.id


    user_data = file("userdata.tpl")
    root_block_device {
        volume_size = 10
    }
    tags = {
        Name = "dev"
    }
  
}