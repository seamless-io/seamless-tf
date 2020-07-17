resource "aws_s3_bucket" "web-packages" {
  bucket = format("web-%s-packages", var.stage)
  acl    = "private"

  tags = {
    Name        = format("Web %s Packages", var.stage)
    Environment = var.stage
  }
}

resource "aws_s3_bucket" "web-jobs" {
  bucket = format("web-%s-jobs", var.stage)
  acl    = "private"

  tags = {
    Name        = format("Web %s Jobs", var.stage)
    Environment = var.stage
  }
}