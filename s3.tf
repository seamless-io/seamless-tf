resource "aws_s3_bucket" "core-prod-packages" {
  bucket = "core-prod-packages"
  acl    = "private"

  tags = {
    Name        = "Core Production Packages"
    Environment = "Prod"
  }
}