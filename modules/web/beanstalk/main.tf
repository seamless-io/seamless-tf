resource "aws_elastic_beanstalk_application" "web" {
  name        = format("web-%s", var.stage)
}

resource "aws_elastic_beanstalk_environment" "web-env" {
  name                = format("web-%s-env", var.stage)
  application         = aws_elastic_beanstalk_application.web.name
  solution_stack_name = "64bit Amazon Linux 2 v3.0.3 running Python 3.7"

  setting {
      namespace = "aws:autoscaling:asg"
      name      = "MaxSize"
      value     = var.max_ec2_instances
    }

  setting {
      namespace = "aws:autoscaling:asg"
      name      = "MinSize"
      value     = var.min_ec2_instances
    }

  setting {
      namespace = "aws:elasticbeanstalk:cloudwatch:logs"
      name      = "StreamLogs"
      value     = true                  # Stream logs to CloudWatch
    }

  setting {
      namespace = "aws:elasticbeanstalk:cloudwatch:logs"
      name      = "RetentionInDays"
      value     = 7                     # Retain logs for 1 week
    }

  setting {
      namespace = "aws:elasticbeanstalk:cloudwatch:logs"
      name      = "DeleteOnTerminate"
      value     = true                  # Delete logs after the Beanstalk app was deleted
    }

  setting {
      namespace = "aws:autoscaling:launchconfiguration"
      name      = "EC2KeyName"
      value     = aws_key_pair.web-key-pair.key_name  # Key pair to access EC2 using ssh
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "AWS_REGION_NAME"
      value     = var.aws_region         # Environment variable needed for boto3 client
    }

  setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "IamInstanceProfile"
        value     = aws_iam_instance_profile.web_instance_profile.name  # Add permissions to ec2 instances
      }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "STAGE"
      value     = var.stage
    }

  # [START] Environment variables for database connection

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "SEAMLESS_DB_NAME"
      value     = var.rds_name
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "SEAMLESS_DB_USER"
      value     = var.rds_user
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "SEAMLESS_DB_PASSWORD"
      value     = var.rds_password
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "SEAMLESS_DB_HOST"
      value     = var.rds_host
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "SEAMLESS_DB_PORT"
      value     = var.rds_port
    }

  # [END] Environment variables for database connection

  # [START] Environment variables for Auth0 connection

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "AUTH0_BASE_URL"
      value     = var.auth0_base_url
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "AUTH0_CALLBACK_URL"
      value     = var.auth0_callback_url
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "AUTH0_WEB_API_AUDIENCE"
      value     =  var.auth0_web_api_audience
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "AUTH0_CLIENT_ID"
      value     = var.auth0_client_id
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "AUTH0_CLIENT_SECRET"
      value     = var.auth0_client_secret
    }

  # [END] Environment variables for Auth0 connection

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "SENTRY_DSN"
      value     = var.sentry_dsn # Environment variable needed for sentry
    }

  # [START] Configuring load balancer

    setting {
      namespace = "aws:elasticbeanstalk:environment"
      name      = "LoadBalancerType"
      value     = "application"
    }

  setting {
      namespace = "aws:elbv2:listener:443"
      name      = "Protocol"
      value     = "HTTPS"
    }

  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "SSLCertificateArns"
    value     = var.ssl_certificate_arn
    }

  # [END] Configuring load balancer

  # [START] Environment variables for working with lambda proxy

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "LAMBDA_PROXY_PASSWORD"
      value     = var.lambda_proxy_password
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "LAMBDA_PROXY_NAME"
      value     = var.lambda_proxy_name
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "LAMBDA_PROXY_ARN"
      value     = var.lambda_proxy_arn
    }

  # [END] Environment variables for working with lambda proxy

  # [START] Environment variables for telegram bot

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "TELEGRAM_BOT_API_KEY"
      value     = var.telegram_bot_api_key
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "TELEGRAM_CHANNEL_ID"
      value     = var.telegram_channel_id
    }

  # [END] Environment variables for telegram bot

  # [START] Environment variables for SMTP server

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "EMAIL_SMTP_USERNAME"
      value     = var.email_smtp_username
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "EMAIL_SMTP_PASSWORD"
      value     = var.email_smtp_password
    }

  # [END] Environment variables for SMTP server

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "EMAIL_AUTOMATION_PASSWORD"
      value     = var.email_automation_password
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "GITHUB_ACTIONS_PASSWORD"
      value     = var.github_actions_password
    }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentPolicy"
    value     = var.deployment_policy
    }

  # [START] Configuring health checks

  setting {
      namespace = "aws:elasticbeanstalk:environment:process:default"
      name      = "HealthCheckPath"
      value     = "/health-check"
    }

  setting {
      namespace = "aws:elasticbeanstalk:environment:process:default"
      name      = "HealthCheckInterval"
      value     = "60"
    }

  # [END] Configuring health checks

  setting {
      namespace = "aws:ec2:instances"
      name      = "InstanceTypes"
      value     = var.ec2_instance_type
    }

}
