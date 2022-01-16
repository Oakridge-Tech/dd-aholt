#S3 bucket for CloudTrail logs
resource "aws_s3_bucket" "cloudtrail-bucket" {
  bucket        = "${var.company-name}-global-cloudtrail-logs"
  force_destroy = true
  acl           = "private"

  #Logging on S3 bucket enabled but redirected to dedicated S3 log bucket. 
  logging {
    target_bucket = aws_s3_bucket.s3-log-bucket.id
    target_prefix = "cloudtrail/"
  }

  policy = data.aws_iam_policy_document.s3-policy.json

    tags = merge(
    local.default_tags,
    {
      project     = "dd-test-questions"
      application = "business-app"
    }
  )
}
#Code to block all public access on CloudTrail log bucket
resource "aws_s3_bucket_public_access_block" "cloudtrail-bucket-block-access" {
  bucket = aws_s3_bucket.cloudtrail-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
#General log bucket 
resource "aws_s3_bucket" "s3-log-bucket" {
  bucket        = "${var.company-name}-s3-log-bucket"
  force_destroy = true
  acl           = "private"


    tags = merge(
    local.default_tags,
    {
      project     = "dd-test-questions"
      application = "logs"
    }
  )
}
#Code to block all public access on S3 log bucket
resource "aws_s3_bucket_public_access_block" "s3-log-bucket-block-access" {
  bucket = aws_s3_bucket.s3-log-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}