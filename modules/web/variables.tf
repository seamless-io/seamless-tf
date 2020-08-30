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

variable "min_ec2_instances" {
  type = number
}

variable "max_ec2_instances" {
  type = number
}

variable "telegram_bot_api_key" {
  type = string
}

variable "telegram_channel_id" {
  type = string
}

variable "email_automation_password" {
  type = string
}

variable "jobs_s3_versioning" {
  type = bool
}

variable "github_actions_password" {
  type = string
}