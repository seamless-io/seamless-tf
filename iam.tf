resource "aws_iam_policy" "core_instance_policy" {   # Allow instances of core to work with cloudwatch
  name        = "core_instance_policy"

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
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "instance_permissions" {
    role = aws_iam_role.core_instance_role.id
    policy_arn = aws_iam_policy.core_instance_policy.arn
}

resource "aws_iam_role" "core_instance_role" {
    name = "core_instance_role"
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

resource "aws_iam_instance_profile" "core_instance_profile" {
  name = "core_instance_profile"
  role = aws_iam_role.core_instance_role.name
}