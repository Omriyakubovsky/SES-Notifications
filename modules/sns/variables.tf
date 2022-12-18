variable "sns_topic_name" {
  type        = string
  description = "SNS topic name"
}
variable "sns_topic_subscription_endpoint" {
  type        = string
  description = "SNS topic subscription endpoint"
}
variable "region" {
  type        = string
  description = "Resources region"
}
variable "ses_domain_identity" {
  type        = string
  description = "SES email domain"
}