resource "aws_iam_policy" "web_instance_policy" {   # Allow instances of web to work with other services
  name        = format("web_%s_instance_policy", var.stage)

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "CloudWatchLogsAccess",
      "Action": [
        "logs:PutLogEvents",
        "logs:CreateLogStream",
        "logs:CreateLogGroup",
        "logs:PutRetentionPolicy",
        "logs:DescribeLogStreams",
        "logs:DescribeLogGroups"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "CloudWatchEventsAccess",
      "Action": [
        "events:PutRule",
        "events:PutTargets"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "QueueAccess",
      "Action": [
        "sqs:ChangeMessageVisibility",
        "sqs:DeleteMessage",
        "sqs:ReceiveMessage",
        "sqs:SendMessage"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "DynamoPeriodicTasks",
      "Action": [
          "dynamodb:BatchGetItem",
          "dynamodb:BatchWriteItem",
          "dynamodb:DeleteItem",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:UpdateItem"
      ],
      "Effect": "Allow",
      "Resource": [
          "arn:aws:dynamodb:*:*:table/*-stack-AWSEBWorkerCronLeaderRegistry*"
      ]
    },
    {
      "Sid": "S3Access",
      "Action": [
        "s3:PutObject",
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "web_instance_permissions" {
    role = aws_iam_role.web_instance_role.id
    policy_arn = aws_iam_policy.web_instance_policy.arn
}

resource "aws_iam_role" "web_instance_role" {
    name = format("web_%s_instance_role", var.stage)
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "web_instance_profile" {
  name = format("web_%s_instance_profile", var.stage)
  role = aws_iam_role.web_instance_role.name
}
