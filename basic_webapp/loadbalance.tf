resource "aws_lb" "webapp_lb" {
  name            = "webapp-lb"
  security_groups = [aws_security_group.webapp_lb_sg.id]
  subnets         = [aws_subnet.webapp_subnet1.id, aws_subnet.webapp_subnet2.id]
  load_balancer_type = "application"
}
resource "aws_lb_listener" "webapp_lb_listener" {
  load_balancer_arn = aws_lb.webapp_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404 not found"
      status_code  = "404"
    }
  }
}
resource "aws_lb_listener_rule" "webapp_lb_listener_rule" {
  listener_arn = aws_lb_listener.webapp_lb_listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp_lb_tg.arn
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

# Here we are creating a target group for the load balancer but not yet attached to any instances to it.
resource "aws_lb_target_group" "webapp_lb_tg" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.webapp_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

# Here we are attaching the instance to the target group
resource "aws_lb_target_group_attachment" "webapp_lb_tg_attachment1" {
  target_group_arn = aws_lb_target_group.webapp_lb_tg.arn
  target_id        = aws_instance.webapp-ec2-1.id
  port             = 8080 # This is the port on which the instance is listening
}

resource "aws_lb_target_group_attachment" "webapp_lb_tg_attachment2" {
  target_group_arn = aws_lb_target_group.webapp_lb_tg.arn
  target_id        = aws_instance.webapp-ec2-2.id
  port             = 8080 # This is the port on which the instance is listening
}





