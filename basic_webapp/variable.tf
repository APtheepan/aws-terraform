variable "instance_type" {
  description = "The type of EC2 instance to launch"
  default     = "t2.micro"
  type = string
}

variable "ami" {
  description = "The AMI ID to launch"
  default     = "ami-0c55b159cbfafe1f0"
  type = string
  
}

variable "db_name" {
  description = "The name of the database"
  default     = "mydb"
  type = string
  
}
variable "region"{
  description = "The region in which to launch the instances"
  default     = "us-east-1"
  type = string
}

variable "db_username" {
  description = "The username for the database"
  default     = "foo"
  type = string
  
}

variable "db_password" {
  description = "The password for the database"
  default     = "foobarbaz"
  type = string
  sensitive = true
}