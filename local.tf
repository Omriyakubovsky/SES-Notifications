locals {
  provider = {
    region = "us-east-1"
  }

  sns = {
    name = "test"
  }

  sqs = {
    name = "test-queue"
  }

  ses = {
    ses_domain_identity = "test-example.com"
    notification_type   = ["Bounce", "Complaint", "Delivery"]
  }
}