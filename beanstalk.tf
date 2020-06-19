resource "aws_elastic_beanstalk_application" "core-prod" {
  name        = "core-prod"
}

resource "aws_elastic_beanstalk_environment" "core-prod-env" {
  name                = "core-prod-env"
  application         = aws_elastic_beanstalk_application.core-prod.name
  solution_stack_name = "64bit Amazon Linux 2 v3.0.2 running Python 3.7"

  setting {
      namespace = "aws:autoscaling:launchconfiguration"
      name      = "IamInstanceProfile"
      value     = "aws-elasticbeanstalk-ec2-role" # I don't know what does it do
    }

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
      value     = aws_key_pair.core-prod-key-pair.key_name  # Key pair to access EC2 using ssh
    }

  setting {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "AWS_REGION_NAME"
      value     = var.AWS_REGION
    }
}