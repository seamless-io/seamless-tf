resource "aws_sqs_queue" "jobs_queue" {
  name                        = "jobs-queue.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}
