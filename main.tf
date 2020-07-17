module "web-prod" {
  source                  = "./modules/web"

  stage                   = "prod"
  aws_region              = var.AWS_REGION
  sentry_dsn              = "https://4ba001ae14664734a6711e4eb87c7f87@o420763.ingest.sentry.io/5339513"
  ssl_certificate_arn     = "arn:aws:acm:us-east-1:202868668807:certificate/c6c35492-9e92-4d6c-bd12-9ff974c373df"
  lambda_proxy_password   = data.aws_kms_secrets.web_prod_lambda_proxy.plaintext["password"]  # Password to authenticate schedule requests
  domain                  = "app.seamlesscloud.io"
  rds_password            = data.aws_kms_secrets.web_prod_rds.plaintext["password"]
  auth0_base_url          = "https://seamlesscloud.us.auth0.com"
  auth0_client_id         = data.aws_kms_secrets.web_prod_env.plaintext["AUTH0_CLIENT_ID"]
  auth0_client_secret     = data.aws_kms_secrets.web_prod_env.plaintext["AUTH0_CLIENT_SECRET"]
  auth0_web_api_audience  = "seamless-web-api"
}

module "web-staging" {
  source                  = "./modules/web"

  stage                   = "staging"
  aws_region              = var.AWS_REGION
  sentry_dsn              = ""
  ssl_certificate_arn     = "arn:aws:acm:us-east-1:202868668807:certificate/267891b7-66fe-4ce8-b54d-2f85fce9b8de"
  lambda_proxy_password   = data.aws_kms_secrets.web_staging_lambda_proxy.plaintext["password"]  # Password to authenticate schedule requests
  domain                  = "staging-app.seamlesscloud.io"
  rds_password            = data.aws_kms_secrets.web_staging_rds.plaintext["password"]
  auth0_base_url          = "https://staging-seamlesscloud.us.auth0.com"
  auth0_client_id         = data.aws_kms_secrets.web_staging_env.plaintext["AUTH0_CLIENT_ID"]
  auth0_client_secret     = data.aws_kms_secrets.web_staging_env.plaintext["AUTH0_CLIENT_SECRET"]
  auth0_web_api_audience  = "seamless-web-api"
}