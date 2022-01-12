resource "aws_s3_bucket" "cloudtrail-bucket" {
  bucket        = "${var.company-name}-global-cloudtrail-logs"
  force_destroy = true
  acl           = "private"

  logging {
    target_bucket = aws_s3_bucket.s3-log-bucket.id
    target_prefix = "log/"
  }

  policy = data.aws_iam_policy_document.s3-policy.json
  
  
#   <<POLICY
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "AWSCloudTrailAclCheck",
#             "Effect": "Allow",
#             "Principal": {
#               "Service": "cloudtrail.amazonaws.com"
#             },
#             "Action": "s3:GetBucketAcl",
#             "Resource": "arn:aws:s3:::${var.company-name}-global-cloudtrail-logs"
#         },
#         {
#             "Sid": "AWSCloudTrailWrite",
#             "Effect": "Allow",
#             "Principal": {
#               "Service": "cloudtrail.amazonaws.com"
#             },
#             "Action": "s3:PutObject",
#             "Resource": "arn:aws:s3:::${var.company-name}-global-cloudtrail-logs/${var.s3-prefix}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
#             "Condition": {
#                 "StringEquals": {
#                     "s3:x-amz-acl": "bucket-owner-full-control"
#                 }
#             }
#         }
#     ]
# }
# POLICY
}


resource "aws_s3_bucket_public_access_block" "cloudtrail-bucket-block-access" {
  bucket = aws_s3_bucket.cloudtrail-bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}



resource "aws_s3_bucket" "s3-log-bucket" {
  bucket        = "${var.company-name}-s3-log-bucket"
  force_destroy = true
  acl           = "private"
}


resource "aws_s3_bucket_public_access_block" "s3-log-bucket-block-access" {
  bucket = aws_s3_bucket.s3-log-bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}