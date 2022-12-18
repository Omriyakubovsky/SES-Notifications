resource "aws_sns_topic" "sns_topic" {
  name = var.sns_topic_name

  tags = {
    Created_By  = "Terraform"
    Environment = "Test"
  }
}

resource "aws_sns_topic_subscription" "sns_topic_subscription_sqs" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "sqs"
  endpoint  = var.sns_topic_subscription_endpoint
}

resource "aws_sns_topic_subscription" "sns_topic_subscription_email" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = var.ses_domain_identity
}

data "aws_caller_identity" "current" {}

resource "aws_sns_topic_policy" "allow_ses" {
  arn = aws_sns_topic.sns_topic.arn

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "notification-policy",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ses.amazonaws.com"
      },
      "Action": "sns:Publish",
      "Resource": "arn:aws:sns:topic_region:data.${data.aws_caller_identity.current.account_id}:${var.sns_topic_name}",
      "Condition": {
        "StringEquals": {
          "AWS:SourceAccount": "${data.aws_caller_identity.current.account_id}",
          "AWS:SourceArn": "arn:aws:ses:${var.region}:${data.aws_caller_identity.current.account_id}:identity/${var.ses_domain_identity}"
        }
      }
    }
  ]
}
POLICY
}