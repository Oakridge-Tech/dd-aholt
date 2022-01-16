resource "aws_sns_topic" "cloudtrail-sns" {
  name         = "aws-cloudtrail-logs-sns"
  display_name = "aws-cloudtrail-logs-sns"

    tags = merge(
    local.default_tags,
    {
      project     = "dd-test-questions"
      application = "business-app"
    }
  )
}