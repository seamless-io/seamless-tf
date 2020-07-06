resource "aws_sqs_queue" "jobs_queue" {
  name                        = "jobs-queue.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "arn:aws:sqs:us-east-1:202868668807:jobs-queue.fifo.fifo.fifo.fifo/SQSDefaultPolicy",
  "Statement": [
    {
      "Sid": "AWSEvents_jobs-queue.fifo",
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
