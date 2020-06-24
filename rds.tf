resource "aws_db_instance" "web_prod" {
  identifier           = "web-prod-rds"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "10.9"
  instance_class       = "db.t2.micro"
  name                 = "seamless"
  username             = "root"
  password             = data.aws_kms_secrets.web_prod_rds.plaintext["password"]
  skip_final_snapshot  = true
  apply_immediately    = true
  publicly_accessible  = true
}