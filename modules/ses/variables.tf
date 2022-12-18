variable "sns_topic_arn" {
  type        = string
  description = "SNS topic arn"
}
variable "notification_type" {
  type        = any
  description = "Notification type"
}
variable "ses_domain_identity" {
  type        = string
  description = "SES email domain"
}