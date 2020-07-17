module "lambda_cloudwatch_handler" {
  source                = "./modules/lambda_cloudwatch_handler"

  file_name             = "schedule_events_proxy.zip"
  function_name         = "schedule_events_proxy"
  handler               = "lambda_function.lambda_handler"
  runtime               = "python3.8"
  timeout               = 10
  environment_variables = {
      SCHEDULE_PASSWORD = data.aws_kms_secrets.web_prod_sns.plaintext["password"]  # Password to authenticate schedule requests
    }
}