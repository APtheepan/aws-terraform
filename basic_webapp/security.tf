resource "aws_key_pair" "webapp-key" {
  key_name   = "mykey"
  public_key = file("~/.ssh/aws_key.pub")
}

resource "aws_security_group" "webapp_sg" {
  vpc_id = aws_vpc.webapp_vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

resource "aws_security_group" "webapp_lb_sg" {
  name = "webapp_lb_sg"
  vpc_id = aws_vpc.webapp_vpc.id
}
resource "aws_security_group_rule" "lb_sg_rule_inbound" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  security_group_id = aws_security_group.webapp_lb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]

}
resource "aws_security_group_rule" "lb_sg_rule_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.webapp_lb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]

}



