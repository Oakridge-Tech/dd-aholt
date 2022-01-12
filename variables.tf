#################
#S3.tf Variables#
#################
variable "company-name" {
    type = string 
    description = "Name of company"
    default = "dd"
}

#########################
#CloudTrail.tf Variables#
#########################
variable "s3-prefix" {
    type = string
    description = "Prefix assigned to bucket object"
    default = "dd-logs"
}
variable "cloudtrail-name" {
    type        = string
    description = "Name for the Cloudtrail"
    default     = "global-cloudtrail-audit"
}

#########################
#CloudWatch.tf Variables#
#########################
variable "cloudwatch-log-group" {
    type = string
    description = "CloudWatch log group name from ClouTrail"
    default = "cloudtrail-events"
}
variable "unauthorized-api-calls" {
  description = "Toggle unauthorized api calls alarm"
  type        = bool
  default     = true
}

##################
#IAM.tf Variables#
##################
variable "iam-role-name" {
    type        = string
    description = "Name for CloudTrail IAM Role to send logs to CloudWatch"
    default     = "cloudtrail-cloudwatch-logs-role"
}


