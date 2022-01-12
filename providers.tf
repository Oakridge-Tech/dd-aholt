terraform {
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = ">= 3.70.0"
      }
  }
}


provider "aws" {
    alias = "london"
    region = "eu-west-2"
}