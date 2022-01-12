
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
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cloudtrail_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudtrail_cloudwatch_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudtrail_kms_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |




## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="company-name"></a> [alarm\_namespace](company\-name) | Name of company - Generic use for unique naing conventions | `string` | `"dd"` | yes |
| <a name="input_alarm_sns_topic_arn"></a> [alarm\_sns\_topic\_arn](#input\_alarm\_sns\_topic\_arn) | SNS topic ARN for generated alarms | `string` | n/a | yes |
| <a name="input_aws_config_changes"></a> [aws\_config\_changes](#input\_aws\_config\_changes) | Toggle AWS Config changes alarm | `bool` | `true` | no |
| <a name="input_cloudtrail_cfg_changes"></a> [cloudtrail\_cfg\_changes](#input\_cloudtrail\_cfg\_changes) | Toggle Cloudtrail config changes alarm | `bool` | `true` | no |
| <a name="input_cloudtrail_log_group_name"></a> [cloudtrail\_log\_group\_name](#input\_cloudtrail\_log\_group\_name) | Cloudwatch log group name for Cloudtrail logs | `string` | `"cloudtrail-events"` | no |
| <a name="input_console_signin_failures"></a> [console\_signin\_failures](#input\_console\_signin\_failures) | Toggle console signin failures alarm | `bool` | `true` | no |
| <a name="input_disable_assumed_role_login_alerts"></a> [disable\_assumed\_role\_login\_alerts](#input\_disable\_assumed\_role\_login\_alerts) | Toggle to disable assumed role console login alerts - violates CIS Benchmark | `bool` | `false` | no |
| <a name="input_disable_or_delete_cmk"></a> [disable\_or\_delete\_cmk](#input\_disable\_or\_delete\_cmk) | Toggle disable or delete CMK alarm | `bool` | `true` | no |
| <a name="input_iam_changes"></a> [iam\_changes](#input\_iam\_changes) | Toggle IAM changes alarm | `bool` | `true` | no |
| <a name="input_nacl_changes"></a> [nacl\_changes](#input\_nacl\_changes) | Toggle network ACL changes alarm | `bool` | `true` | no |
| <a name="input_network_gw_changes"></a> [network\_gw\_changes](#input\_network\_gw\_changes) | Toggle network gateway changes alarm | `bool` | `true` | no |
| <a name="input_no_mfa_console_login"></a> [no\_mfa\_console\_login](#input\_no\_mfa\_console\_login) | Toggle no MFA console login alarm | `bool` | `true` | no |
| <a name="input_root_usage"></a> [root\_usage](#input\_root\_usage) | Toggle root usage alarm | `bool` | `true` | no |
| <a name="input_route_table_changes"></a> [route\_table\_changes](#input\_route\_table\_changes) | Toggle route table changes alarm | `bool` | `true` | no |
| <a name="input_s3_bucket_policy_changes"></a> [s3\_bucket\_policy\_changes](#input\_s3\_bucket\_policy\_changes) | Toggle S3 bucket policy changes alarm | `bool` | `true` | no |
| <a name="input_security_group_changes"></a> [security\_group\_changes](#input\_security\_group\_changes) | Toggle security group changes alarm | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for resources created | `map(string)` | `{}` | no |
| <a name="input_unauthorized_api_calls"></a> [unauthorized\_api\_calls](#input\_unauthorized\_api\_calls) | Toggle unauthorized api calls alarm | `bool` | `true` | no |
| <a name="input_vpc_changes"></a> [vpc\_changes](#input\_vpc\_changes) | Toggle VPC changes alarm | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudtrail_arn"></a> [cloudtrail\_arn](#output\_cloudtrail\_arn) | CloudTrail ARN |
| <a name="output_cloudtrail_home_region"></a> [cloudtrail\_home\_region](#output\_cloudtrail\_home\_region) | CloudTrail Home Region |
| <a name="output_cloudtrail_id"></a> [cloudtrail\_id](#output\_cloudtrail\_id) | CloudTrail ID |
