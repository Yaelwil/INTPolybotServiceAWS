/*
 The terraform {} block contains Terraform settings, including the required providers Terraform will use to provision infrastructure.
 Terraform installs providers from the Terraform Registry by default.
 In this example configuration, the aws provider's source is defined as hashicorp/aws,
*/
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.16"
    }
  }

  required_version = ">= 1.2.0"

    backend "s3" {
    bucket = "yaelwil-bucket-tf-project-tfstate-file"
    key    = "tfstate.json"
    region = "eu-west-1"
    # optional: dynamodb_table = "<table-name>"
  }
}