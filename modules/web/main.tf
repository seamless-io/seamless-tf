module "lambda_cloudwatch_handler" {
  source                = "./lambda_cloudwatch_handler"

  stage                 = var.stage
  environment_variables = {
      SCHEDULE_PASSWORD = var.lambda_proxy_password
      DOMAIN            = var.domain
    }
}

module "rds" {
  source                  = "./rds"

  stage                   = var.stage
  password                = var.rds_password
  backups                 = var.rds_backups
  rds_deletion_protection = var.rds_deletion_protection
}

module "beanstalk" {
  source                    = "./beanstalk"

  stage                     = var.stage
  aws_region                = var.aws_region
  rds_name                  = module.rds.name
  rds_user                  = module.rds.user
  rds_password              = module.rds.password
  rds_host                  = module.rds.host
  rds_port                  = module.rds.port
  auth0_base_url            = var.auth0_base_url
  auth0_callback_url        = format("https://%s/callback", var.domain)
  auth0_web_api_audience    = var.auth0_web_api_audience
  auth0_client_id           = var.auth0_client_id
  auth0_client_secret       = var.auth0_client_secret
  sentry_dsn                = var.sentry_dsn
  lambda_proxy_name         = module.lambda_cloudwatch_handler.name
  lambda_proxy_arn          = module.lambda_cloudwatch_handler.arn
  lambda_proxy_password     = var.lambda_proxy_password
  ssl_certificate_arn       = var.ssl_certificate_arn
  deployment_policy         = var.deployment_policy
  ec2_instance_type         = var.ec2_instance_type
  min_ec2_instances         = var.min_ec2_instances
  max_ec2_instances         = var.max_ec2_instances
  telegram_bot_api_key      = var.telegram_bot_api_key
  telegram_channel_id       = var.telegram_channel_id
  email_automation_password = var.email_automation_password
  jobs_s3_versioning        = var.jobs_s3_versioning
  github_actions_password   = var.github_actions_password
  email_smtp_username       = var.email_smtp_username
  email_smtp_password       = var.email_smtp_password
}