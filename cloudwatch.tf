#Resource to add a CloudWatch Log group to recieve logs from CloudTrail. 

resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = var.cloudwatch-log-group
  retention_in_days = 1 #Retention set to 1 day for testing. Should be set to 0 days for go live. 
  kms_key_id        = aws_kms_key.cloudtrail-kms.arn

  tags = merge(
    local.default_tags,
    {
      project     = "dd-test-questions"
      application = "business-app"
    }
  )
}

#########################################
# Event alarm for unauthorised API calls#
#########################################
resource "aws_cloudwatch_log_metric_filter" "unauthorized-api-calls" {
  count = var.unauthorized-api-calls ? 1 : 0

  name           = "UnauthorizedAPICalls"
  pattern        = "{ ($.errorCode = \"*UnauthorizedOperation\") || ($.errorCode = \"AccessDenied*\") }"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  metric_transformation {
    name      = "UnauthorizedAPICalls"
    namespace = "CloudTrail"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "unauthorized-api-calls" {
  count = var.unauthorized-api-calls ? 1 : 0

  alarm_name                = "UnauthorizedAPICalls"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = aws_cloudwatch_log_metric_filter.unauthorized-api-calls[0].id
  namespace                 = "CloudTrail"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Monitoring unauthorized API calls will help reveal application errors and may reduce time to detect malicious activity."
  alarm_actions             = [aws_sns_topic.cloudtrail-sns.arn]
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []

}

#############################
# Event alarm for root login#
#############################
resource "aws_cloudwatch_log_metric_filter" "root-login" {
  name           = "root-access"
  pattern        = "{$.userIdentity.type = Root}"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  metric_transformation {
    name      = "RootAccessCount"
    namespace = "CloudTrail"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "root-login" {
  alarm_name          = "root-access-${data.aws_region.current.name}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "RootAccessCount"
  namespace           = "CloudTrail"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "Use of the root account has been detected"
  alarm_actions       = [aws_sns_topic.cloudtrail-sns.arn]
}

############################################
# Event alarm for console login without MFA#
############################################
resource "aws_cloudwatch_log_metric_filter" "console-login-without-mfa" {
  name           = "console-login-without-mfa"
  pattern        = "{$.eventName = ConsoleLogin && $.additionalEventData.MFAUsed = No}"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  metric_transformation {
    name      = "ConsoleLoginWithoutMFACount"
    namespace = "CloudTrail"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "console-login-without-mfa" {
  alarm_name          = "console-login-without-mfa-${data.aws_region.current.name}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ConsoleLoginWithoutMFACount"
  namespace           = "CloudTrail"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "Use of the console by an account without MFA has been detected"
  alarm_actions       = [aws_sns_topic.cloudtrail-sns.arn]
}

############################################################
# Event alarm for actions triggered by accounts without MFA#
############################################################
resource "aws_cloudwatch_log_metric_filter" "action_without_mfa" {
  name           = "action-without-mfa"
  pattern        = "{$.userIdentity.type != AssumedRole && $.userIdentity.sessionContext.attributes.mfaAuthenticated != true}"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name

  metric_transformation {
    name      = "ActionWithoutMFACount"
    namespace = "CloudTrail"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "action_without_mfa" {
  alarm_name          = "action-without-mfa-${data.aws_region.current.name}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ActionWithoutMFACount"
  namespace           = "CloudTrail"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "Actions triggered by a user account without MFA has been detected"
  alarm_actions       = [aws_sns_topic.cloudtrail-sns.arn]
}
