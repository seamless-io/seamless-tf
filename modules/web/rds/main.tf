resource "aws_db_parameter_group" "web_rds_parameter_group" {
  name   = format("web-%s-rds-parameter-group", var.stage)
  family = "postgres10"

  parameter {
    name  = "rds.force_ssl"
    value = 1  # Force all connections to the database to use SSL (you can get the certificate here https://s3.amazonaws.com/rds-downloads/rds-ca-2019-root.pem)
  }
}

resource "aws_db_instance" "web" {
  identifier                      = format("web-%s-rds", var.stage)
  allocated_storage               = 20
  storage_type                    = "gp2"
  engine                          = "postgres"
  engine_version                  = "10.9"
  instance_class                  = "db.t2.micro"
  name                            = "seamless"
  username                        = "root"
  password                        = var.password
  backup_retention_period         = var.backups ? 7 : 0
  skip_final_snapshot             = var.backups ? false : true
  final_snapshot_identifier       = format("web-%s-rds-final-snapshot", var.stage)
  deletion_protection             = var.rds_deletion_protection
  apply_immediately               = true
  publicly_accessible             = true
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  vpc_security_group_ids          = [aws_security_group.rds_security_group.id]
  parameter_group_name            = aws_db_parameter_group.web_rds_parameter_group.name
}