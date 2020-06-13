variable "AWS_REGION" {
  default = "us-east-1"
}

variable "PRIVATE_KEY_PATH" {
  default = "seamless-core-prod-key-pair"
}

variable "PUBLIC_KEY_PATH" {
  default = "seamless-core-prod-key-pair.pub"
}

variable "EC2_USER" {
  default = "ubuntu"
}

variable "AMI" {
  default = "ami-0a0ddd875a1ea2c7f"
}

variable "INSTANCE_TYPE" {
  default = "t2.nano"
}