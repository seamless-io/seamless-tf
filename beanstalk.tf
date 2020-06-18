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
      value     = "aws-elasticbeanstalk-ec2-role"
    }
}