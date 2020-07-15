#####################################################
##                    Web Prod                     ##
#####################################################


resource "aws_elastic_beanstalk_application" "web-prod" {
  name        = "web-prod"
}

resource "aws_elastic_beanstalk_environment" "web-prod-env" {
  name                = "web-prod-env"
  application         = aws_elastic_beanstalk_application.web-prod.name
  solution_stack_name = "64bit Amazon Linux 2 v3.0.3 running Python 3.7"

  setting {
      namespace = "aws:autoscaling:asg"
      name      = "MaxSize"
      value     = 1                     # Create no more than 1 EC2 instance
    }

  setting {
      namespace = "aws:elasticbeanstalk:cloudwatch:logs"
      name      = "StreamLogs"
      value     = true                  # Stream logs to CloudWatch
    }

  setting {
      namespace = "aws:elasticbeanstalk:cloudwatch:logs"
      name      = "RetentionInDays"
      value     = 1                     # Retain logs for only 1 day
    }

  setting {
      namespace = "aws:elasticbeanstalk:cloudwatch:logs"
      name      = "DeleteOnTerminate"
      value     = true                  # Delete logs after the Beanstalk app was deleted
    }

  setting {
      namespace = "aws:autoscaling:launchconfiguration"
      name      = "EC2KeyName"
      value     = aws_key_pair.web-prod-key-pair.key_name  # Key pair to access EC2 using ssh
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "AWS_REGION_NAME"
      value     = var.AWS_REGION         # Environment variable needed for boto3 client
    }

  setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "IamInstanceProfile"
        value     = aws_iam_instance_profile.web_instance_profile.name  # Add permissions to ec2 instances
      }

  # [START] Environment variables for database connection

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "SEAMLESS_DB_NAME"
      value     = aws_db_instance.web_prod.name
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "SEAMLESS_DB_USER"
      value     = aws_db_instance.web_prod.username
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "SEAMLESS_DB_PASSWORD"
      value     = aws_db_instance.web_prod.password
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "SEAMLESS_DB_HOST"
      value     = aws_db_instance.web_prod.address
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "SEAMLESS_DB_PORT"
      value     = aws_db_instance.web_prod.port
    }

  # [END] Environment variables for database connection

  # [START] Environment variables for Auth0 connection

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "AUTH0_BASE_URL"
      value     = "https://seamlesscloud.us.auth0.com"
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "AUTH0_CALLBACK_URL"
      value     = "http://app.seamlesscloud.io/callback"
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "AUTH0_WEB_API_AUDIENCE"
      value     = "web-prod-env.eba-qdrmggn8.us-east-1.elasticbeanstalk.com/core" # no API calls are made to this url and I cannot change it in Auth0 after creation
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "AUTH0_CLIENT_ID"
      value     = data.aws_kms_secrets.web_prod_env.plaintext["AUTH0_CLIENT_ID"]
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "AUTH0_CLIENT_SECRET"
      value     = data.aws_kms_secrets.web_prod_env.plaintext["AUTH0_CLIENT_SECRET"]
    }

  # [END] Environment variables for Auth0 connection

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "AWS_REGION_NAME"
      value     = var.AWS_REGION         # Environment variable needed for boto3 client
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "SENTRY_DSN"
      value     = "https://4ba001ae14664734a6711e4eb87c7f87@o420763.ingest.sentry.io/5339513" # Environment variable needed for sentry
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
    value     = "arn:aws:acm:us-east-1:202868668807:certificate/c6c35492-9e92-4d6c-bd12-9ff974c373df"
    }

  # [END] Configuring load balancer

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "SCHEDULE_PASSWORD"
      value     = data.aws_kms_secrets.web_prod_sns.plaintext["password"]  # Password to authenticate schedule requests from lambda
    }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentPolicy"
    value     = "RollingWithAdditionalBatch" # https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features.rolling-version-deploy.html
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

}
