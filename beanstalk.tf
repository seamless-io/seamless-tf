#####################################################
##                    Core Prod                    ##
#####################################################

resource "aws_elastic_beanstalk_application" "core-prod" {
  name        = "core-prod"
}

resource "aws_elastic_beanstalk_environment" "core-prod-env" {
  name                = "core-prod-env"
  application         = aws_elastic_beanstalk_application.core-prod.name
  solution_stack_name = "64bit Amazon Linux 2 v3.0.2 running Python 3.7"

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
      value     = var.AWS_REGION         # Environment variable needed for boto3 client
    }

  setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "IamInstanceProfile"
        value     = aws_iam_instance_profile.core_instance_profile.name  # Add permissions to ec2 instances
      }
}


#####################################################
##                    Web Prod                     ##
#####################################################


resource "aws_elastic_beanstalk_application" "web-prod" {
  name        = "web-prod"
}

resource "aws_elastic_beanstalk_environment" "web-prod-env" {
  name                = "web-prod-env"
  application         = aws_elastic_beanstalk_application.web-prod.name
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.20.3 running Multi-container Docker 19.03.6-ce (Generic)"

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
}