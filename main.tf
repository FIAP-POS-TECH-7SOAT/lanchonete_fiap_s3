terraform {
  required_version = "1.9.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.63.0"
    }
  }
}


provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  token      = var.aws_session_token
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "lanchonete-fiap-bucket" {
  bucket = "lanchonete-fiap-${data.aws_caller_identity.current.account_id}"
  tags = {
   Description ="Store everything about lanchonete fiap"
   ManagedBy = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "lanchonete-fiap-versioning" {
  bucket = aws_s3_bucket.lanchonete-fiap-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

output "aws_s3_bucket_lanchonete_fiap" {
  value = aws_s3_bucket.lanchonete-fiap-bucket.bucket
}
output "aws_s3_bucket_lanchonete_fiap_arn" {
  value = aws_s3_bucket.lanchonete-fiap-bucket.arn
}
