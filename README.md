
# Enabling CloudTrail and Alerting 

This code is designed to create: 
```text
 - CloudTrail enabled in all regions.
 - CloudTrail log file validation is enabled.
 - Both management and global events are captured with CloudTrail.
 - CloudTrail logs are encrypted at rest using KMS customer managed CMK's. 
 - CloudTrail logs are stored in an S3 bucket that has all public access blocked. 
 - S3 bucket access logging is enabled. 
 - CloudTrail trail is configured with CloudWatch Log Group. 
 - Alerting set up to send email on API calls, console sign in without MFA and usage of the root account. 
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.70.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_cloudwatch_log_group.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_metric_filter.console_signin_failures](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_metric_filter) | resource |
| [aws_cloudwatch_log_metric_filter.no_mfa_console_signin_assumed_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_metric_filter) | resource |
| [aws_cloudwatch_log_metric_filter.no_mfa_console_signin_no_assumed_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_metric_filter) | resource |
| [aws_cloudwatch_log_metric_filter.root_usage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_metric_filter) | resource |
| [aws_cloudwatch_metric_alarm.console_signin_failures](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.no_mfa_console_signin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.root_usage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.unauthorized_api_calls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_iam_policy.cloudtrail_cloudwatch_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.cloudtrail_cloudwatch_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_kms_alias.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_cloudwatch_metric_alarm](https://github.com/trussworks/terraform-aws-cloudtrail-alarms/blob/main/main.tf) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document](https://github.com/clouddrove/terraform-aws-cloudtrail/blob/master/main.tf) | data source |
| [aws_iam_policy_document.cloudtrail_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudtrail_cloudwatch_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudtrail_kms_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="company-name"></a> [company\_name](company\-name) | Name of company - Generic use for unique naing conventions | `string` | `"dd"` | yes |
| <a name="s3-prefix"></a> [s3\-prefix](#s3-prefix) | Prefix assigned to bucket object | `string` | `dd-logs` | yes |
| <a name="cloudtrail-name"></a> [cloudtrail\-name](#cloudtrail\-name) | Name for the Cloudtrail | `string` | `global-cloudtrail-audit` | yes |
| <a name="cloudwatch-log-group"></a> [cloudwatch\-log\-group](cloudwatch\-log\-group) | CloudWatch log group name from ClouTrail | `string` | `cloudtrail-events` | yes |
| <a name="unauthorized-api-calls"></a> [unauthorized\-api\-calls](#unauthorized\-api\-calls) | Cloudwatch log group name for Cloudtrail logs | `string` | `"cloudtrail-events"` | no |
| <a name="iam-role-name"></a> [iam\-role\-name](#iam\-role\-name) | Name for CloudTrail IAM Role to send logs to CloudWatch | `string` | `cloudtrail-cloudwatch-logs-role` | yes |

## Outputs

| Name | Description |
|------|-------------|

