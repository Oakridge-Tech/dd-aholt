

variable "aws-account" {
    type = number 
    description = "Account number of aws account"
    default = 083118431604
}

#################
#S3.tf Variables#
#################

variable "s3-prefix" {
    type = string
    description = "Prefix assigned to bucket object"
    default = "logs"
}
variable "company-name" {
    type = string 
    description = "Name of company"
    default = "dd"
}



variable "region" {
    type = string
    description = "Default region"
    default = "eu-west-2"
}

variable "cloudwatch-log-group" {
    type = string
    description = "CloudWatch log group name from ClouTrail"
    default = "cloudtrail-events"
}

variable "cloudtrail-name" {
    type        = string
    description = "Name for the Cloudtrail"
    default     = "global-cloudtrail-audit"
}


variable "iam-role-name" {
    type        = string
    description = "Name for CloudTrail IAM Role to send logs to CloudWatch"
    default     = "cloudtrail-cloudwatch-logs-role"
}
