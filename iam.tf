#Role creation for CloudTrail to send logs to CloudWatch.
resource "aws_iam_role" "cloudtrail-cloudwatch-role" {
  name               = var.iam-role-name
  assume_role_policy = data.aws_iam_policy_document.cloudtrail-assume-role.json
}
#Policy used by the CloudTrail role to send logs to CloudWatch
resource "aws_iam_policy" "cloudtrail-cloudwatch-logs" {
  name   = "cloudtrail-cloudwatch-logs-policy"
  policy = data.aws_iam_policy_document.cloudtrail-cloudwatch-logs.json
}
#Policy attachement resource to attach CloudTrail role to CloudTrail policy. 
resource "aws_iam_policy_attachment" "main" {
  name       = "cloudtrail-cloudwatch-logs-policy-attachment"
  policy_arn = aws_iam_policy.cloudtrail-cloudwatch-logs.arn
  roles      = [aws_iam_role.cloudtrail-cloudwatch-role.name]
}