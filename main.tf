module "web-prod" {
  source                    = "./modules/web"

  stage                     = "prod"
  aws_region                = var.AWS_REGION
  sentry_dsn                = "https://4ba001ae14664734a6711e4eb87c7f87@o420763.ingest.sentry.io/5339513"
  ssl_certificate_arn       = "arn:aws:acm:us-east-1:202868668807:certificate/c6c35492-9e92-4d6c-bd12-9ff974c373df"
  lambda_proxy_password     = data.aws_kms_secrets.web_prod_lambda_proxy.plaintext["password"]  # Password to authenticate schedule requests
  domain                    = "app.seamlesscloud.io"
  rds_password              = data.aws_kms_secrets.web_prod_rds.plaintext["password"]
  rds_backups               = true
  rds_deletion_protection   = true
  auth0_base_url            = "https://seamlesscloud.us.auth0.com"
  auth0_client_id           = data.aws_kms_secrets.web_prod_env.plaintext["AUTH0_CLIENT_ID"]
  auth0_client_secret       = data.aws_kms_secrets.web_prod_env.plaintext["AUTH0_CLIENT_SECRET"]
  auth0_web_api_audience    = "seamless-web-api"
  deployment_policy         = "RollingWithAdditionalBatch" # https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.rolling-version-deploy.html
  ec2_instance_type         = "t2.micro"
  min_ec2_instances         = 1
  max_ec2_instances         = 5
  telegram_bot_api_key      = "1255342796:AAEizpkIceVD7saXaaCCOYvEBk5khnvABn8"
  telegram_channel_id       = "-1001387753505"
  email_automation_password = data.aws_kms_secrets.andrey_gmail_app.plaintext["password"]
  jobs_s3_versioning        = true
  github_actions_password   = ""
}

module "web-staging" {
  source                    = "./modules/web"

  stage                     = "staging"
  aws_region                = var.AWS_REGION
  sentry_dsn                = ""
  ssl_certificate_arn       = "arn:aws:acm:us-east-1:202868668807:certificate/267891b7-66fe-4ce8-b54d-2f85fce9b8de"
  lambda_proxy_password     = data.aws_kms_secrets.web_staging_lambda_proxy.plaintext["password"]  # Password to authenticate schedule requests
  domain                    = "staging-app.seamlesscloud.io"
  rds_password              = data.aws_kms_secrets.web_staging_rds.plaintext["password"]
  rds_backups               = false
  rds_deletion_protection   = false
  auth0_base_url            = "https://staging-seamlesscloud.us.auth0.com"
  auth0_client_id           = data.aws_kms_secrets.web_staging_env.plaintext["AUTH0_CLIENT_ID"]
  auth0_client_secret       = data.aws_kms_secrets.web_staging_env.plaintext["AUTH0_CLIENT_SECRET"]
  auth0_web_api_audience    = "seamless-web-api"
  deployment_policy         = "AllAtOnce" # https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.rolling-version-deploy.html
  ec2_instance_type         = "t2.micro"
  min_ec2_instances         = 1
  max_ec2_instances         = 5
  telegram_bot_api_key      = ""
  telegram_channel_id       = ""
  email_automation_password = ""
  jobs_s3_versioning        = false
  github_actions_password   = data.aws_kms_secrets.andrey_gmail_app.plaintext["password"]
}