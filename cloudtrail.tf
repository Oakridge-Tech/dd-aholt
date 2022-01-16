#Resource to add CloudTrail globally accross all accounts. 
resource "aws_cloudtrail" "cloudtrail-audit" {
  name                          = var.cloudtrail-name
  s3_bucket_name                = aws_s3_bucket.cloudtrail-bucket.id
  s3_key_prefix                 = var.s3-prefix
  include_global_service_events = true #enabled to capture logs from services such as IAM 
  # is_organization_trail         = true
  is_multi_region_trail      = true
  enable_log_file_validation = true
  kms_key_id                 = aws_kms_key.cloudtrail-kms.arn
  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.cloudtrail.arn}:*" #CloudWatch Logs enabled to monitor CloudTrail logs and notify of specific activity
  cloud_watch_logs_role_arn  = aws_iam_role.cloudtrail-cloudwatch-role.arn

  tags = merge(
    local.default_tags,
    {
      project     = "dd-test-questions"
      application = "business-app"
    }
  )
}