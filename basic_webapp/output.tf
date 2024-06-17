output "load_balancer_dns" {
  value = aws_lb.webapp_lb.dns_name
  description = "The DNS name of the load balancer"
}
output "instance1_ip" {
  value = aws_instance.webapp-ec2-1.public_ip
  description = "The public IP address of the EC2 instance" 
}

output "instance2_ip" {
  value = aws_instance.webapp-ec2-2.public_ip
  description = "The public IP address of the EC2 instance" 
}