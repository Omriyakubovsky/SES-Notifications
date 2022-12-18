#Creates SNS topic
module "sns_topic" {
  source                          = "./modules/sns"
  sns_topic_name                  = local.sns.name
  sns_topic_subscription_endpoint = module.sqs_queue.sqs_queue_arn
  region                          = local.provider.region
  ses_domain_identity             = local.ses.ses_domain_identity
}

#Creates SQS queue topic
module "sqs_queue" {
  source         = "./modules/sqs"
  sqs_queue_name = local.sqs.name
  sns_topic_arn  = module.sns_topic.sns_topic_arn
}

#Creates SES notification(Bounce, Complaint, Delivery) via SNS topic
module "ses" {
  source              = "./modules/ses"
  notification_type   = local.ses.notification_type
  ses_domain_identity = local.ses.ses_domain_identity
  sns_topic_arn       = module.sns_topic.sns_topic_arn
}