variable "stage" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "rds_name" {
  type = string
}

variable "rds_user" {
  type = string
}

variable "rds_password" {
  type = string
}

variable "rds_host" {
  type = string
}

variable "rds_port" {
  type = string
}

variable "auth0_callback_url" {
  type = string
}

variable "auth0_web_api_audience" {
  type = string
}

variable "auth0_client_id" {
  type = string
}

variable "auth0_client_secret" {
  type = string
}

variable "sentry_dsn" {
  type = string
}

variable "lambda_proxy_name" {
  type = string
}

variable "lambda_proxy_arn" {
  type = string
}

variable "lambda_proxy_password" {
  type = string
}

variable "ssl_certificate_arn" {
  type = string
}