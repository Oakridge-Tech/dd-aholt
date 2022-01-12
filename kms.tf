resource "aws_kms_key" "cloudtrail-kms" {
  description             = "KMS key to encrypt CloudTrail log stored in S3."
  deletion_window_in_days = 7
  enable_key_rotation     = "true"
  policy                  = data.aws_iam_policy_document.cloudtrail-kms-policy.json
}

resource "aws_kms_alias" "cloudtrail" {
  name          = "alias/${var.cloudtrail-name}"
  target_key_id = aws_kms_key.cloudtrail-kms.key_id
}

