resource "aws_iam_role" "iam_for_schedule_events_proxy_lambda" {
  name = "iam_for_schedule_events_proxy_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "schedule_events_proxy" {
  filename          = "schedule_events_proxy.zip"
  function_name     = "schedule_events_proxy"
  role              = aws_iam_role.iam_for_schedule_events_proxy_lambda.arn
  handler           = "lambda_function.lambda_handler"
  source_code_hash  = filebase64sha256("schedule_events_proxy.zip")
  runtime           = "python3.8"
  depends_on        = [aws_iam_role_policy_attachment.schedule_events_proxy_lambda_logs]

  environment {
    variables = {
      SCHEDULE_PASSWORD = data.aws_kms_secrets.web_prod_sns.plaintext["password"]  # Password to authenticate schedule requests
    }
  }
}

resource "aws_iam_policy" "schedule_events_proxy_lambda_logging" {
  name        = "schedule_events_proxy_lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:CreateLogGroup"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "schedule_events_proxy_lambda_logs" {
  role       = aws_iam_role.iam_for_schedule_events_proxy_lambda.name
  policy_arn = aws_iam_policy.schedule_events_proxy_lambda_logging.arn
}
