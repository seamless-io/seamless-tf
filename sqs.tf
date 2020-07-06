resource "aws_sqs_queue" "jobs" {
  name                        = "jobs.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "arn:aws:sqs:us-east-1:202868668807:jobs.fifo.fifo/SQSDefaultPolicy",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sqs:SendMessage"
    }
  ]
}
EOF
}
