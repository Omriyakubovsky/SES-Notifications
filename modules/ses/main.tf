resource "aws_ses_domain_identity" "ses_domain_identity" {
  domain = "test-example.com"
}

resource "aws_ses_identity_notification_topic" "ses_identity_notification_topic" {
  for_each                 = toset(var.notification_type)
  topic_arn                = var.sns_topic_arn
  notification_type        = each.value
  identity                 = var.ses_domain_identity
  include_original_headers = true
}