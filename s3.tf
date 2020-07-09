resource "aws_s3_bucket" "web-prod-packages" {
  bucket = "web-prod-packages"
  acl    = "private"

  tags = {
    Name        = "Web Production Packages"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket" "web-prod-jobs" {
  bucket = "web-prod-jobs"
  acl    = "private"

  tags = {
    Name        = "Web Production Jobs"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket" "web-prod-load-balancer-access-logs" {
  bucket = "web-prod-load-balancer-access-logs"
  acl    = "private"

  tags = {
    Name        = "Web Production Load Balancer Access Logs"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_policy" "web-prod-load-balancer-access-logs-policy" {
  bucket = aws_s3_bucket.web-prod-load-balancer-access-logs.bucket

  # 127311923021 - elb account id. Not sure what it means, jsut read this https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html#access-logging-bucket-permissions
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::127311923021:root"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::web-prod-load-balancer-access-logs/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::web-prod-load-balancer-access-logs/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::web-prod-load-balancer-access-logs"
        }
    ]
}
POLICY
}