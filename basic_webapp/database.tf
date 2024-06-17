resource "aws_db_instance" "webapp_DB" {
  db_name                     = var.db_name
  allocated_storage          = 20
  auto_minor_version_upgrade = true
  storage_type               = "standard"
  engine                     = "postgres"
  engine_version             = "12"
  instance_class             = "db.t2.micro" 
  username                   = var.db_username
  password                   = var.db_password
  skip_final_snapshot        = true
  
}