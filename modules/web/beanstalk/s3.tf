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

  versioning {
    enabled = var.jobs_s3_versioning
  }
}

resource "aws_s3_bucket" "web-job-templates" {
  bucket = format("web-%s-job-templates", var.stage)
  acl    = "private"

  tags = {
    Name        = format("Web %s Job Templates", var.stage)
    Environment = var.stage
  }

  versioning {
    enabled = var.jobs_s3_versioning
  }
}