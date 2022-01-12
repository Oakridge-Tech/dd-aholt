#Resource to add a CloudWatch Log group to recieve logs from CloudTrail. 

resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = var.cloudwatch-log-group
  retention_in_days = 1 #Retention set to 1 day for testing. Should be set to 0 days for go live. 
  kms_key_id        = aws_kms_key.cloudtrail-kms.arn
}