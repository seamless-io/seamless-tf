resource "aws_s3_bucket" "web-prod-packages" {
  bucket = "web-prod-packages"
  acl    = "private"

  tags = {
    Name        = "Web Production Packages"
    Environment = "Prod"
  }
}