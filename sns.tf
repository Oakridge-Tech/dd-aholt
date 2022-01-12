resource "aws_sns_topic" "cloudtrail-sns" {
  name = "aws-cloudtrail-logs-sns"
  display_name = "aws-cloudtrail-logs-sns"
# delivery_policy = <<EOF

# {
#   "Version": "2008-10-17",
#   "Id": "__default_policy_ID",
#   "Statement": [
#     {
#       "Sid": "__default_statement_ID",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "*"
#       },
#       "Action": [
#         "SNS:GetTopicAttributes",
#         "SNS:SetTopicAttributes",
#         "SNS:AddPermission",
#         "SNS:RemovePermission",
#         "SNS:DeleteTopic",
#         "SNS:Subscribe",
#         "SNS:ListSubscriptionsByTopic",
#         "SNS:Publish"
#       ],
#       "Resource": "arn:aws:sns:eu-west-2:083118431604:aws-cloudtrail-logs-sns",
#       "Condition": {
#         "StringEquals": {
#           "AWS:SourceOwner": "083118431604"
#         }
#       }
#     },
#     {
#       "Sid": "AWSCloudTrailSNSPolicy20150319",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "cloudtrail.amazonaws.com"
#       },
#       "Action": "SNS:Publish",
#       "Resource": "arn:aws:sns:eu-west-2:083118431604:aws-cloudtrail-logs-sns",
#       "Condition": {
#         "StringEquals": {
#           "AWS:SourceArn": "arn:aws:cloudtrail:eu-west-2:083118431604:trail/global-cloudtrail-audit"
#         }
#       }
#     }
#   ]
# EOF
}