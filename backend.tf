terraform {
  backend "s3" {
    bucket = "seamless-tf-state"
    key    = "core/terraform.tfstate"
    region = "us-east-1"
  }
}