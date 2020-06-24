resource "aws_db_parameter_group" "web_prod_rds_parameter_group" {
  name   = "web-prod-rds-parameter-group"
  family = "postgres10"

  parameter {
    name  = "rds.force_ssl"
    value = 1  # Force all connections to the database to use SSL (you can get the certificate here https://s3.amazonaws.com/rds-downloads/rds-ca-2019-root.pem)
  }
}

resource "aws_db_instance" "web_prod" {
  identifier             = "web-prod-rds"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "10.9"
  instance_class         = "db.t2.micro"
  name                   = "seamless"
  username               = "root"
  password               = data.aws_kms_secrets.web_prod_rds.plaintext["password"]
  skip_final_snapshot    = true
  apply_immediately      = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.allow_internet_access_to_rds.id]
  parameter_group_name   = aws_db_parameter_group.web_prod_rds_parameter_group.name
}