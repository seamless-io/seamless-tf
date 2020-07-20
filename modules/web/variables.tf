variable "stage" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "sentry_dsn" {
  type = string
}

variable "ssl_certificate_arn" {
  type = string
}

variable "lambda_proxy_password" {
  type = string
}

variable "domain" {
  type = string
}

variable "rds_password" {
  type = string
}

variable "rds_backups" {
  type = bool
}

variable "rds_deletion_protection" {
  type = bool
}

variable "auth0_base_url" {
  type = string
}

variable "auth0_client_id" {
  type = string
}

variable "auth0_client_secret" {
  type = string
}

variable "auth0_web_api_audience" {
  type = string
}

variable "deployment_policy" {
  type = string
}

variable "ec2_instance_type" {
  type = string
}