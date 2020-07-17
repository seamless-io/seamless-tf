resource "aws_iam_role" "iam_for_lambda" {
  name = format("iam_for_%s_lambda", var.function_name)

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

resource "aws_lambda_function" "function" {
  filename          = var.file_name
  function_name     = var.function_name
  role              = aws_iam_role.iam_for_lambda.arn
  handler           = var.handler
  source_code_hash  = filebase64sha256(var.file_name)
  runtime           = var.runtime
  timeout           = var.timeout
  depends_on        = [aws_iam_role_policy_attachment.lambda_logs]

  environment {
    variables = var.environment_variables
  }
}

resource "aws_iam_policy" "lambda_logging" {
  name        = format("%s_lambda_logging", var.function_name)
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

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.function.function_name
  principal     = "events.amazonaws.com"
}
