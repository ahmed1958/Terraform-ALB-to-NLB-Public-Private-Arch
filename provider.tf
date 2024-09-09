provider "aws"{
    shared_config_files = ["/home/ahmed/.aws/config"]
    shared_credentials_files =["/home/ahmed/.aws/credentials"]
    profile = "admin"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.64.0"
    }
  }
     backend "s3" {
        bucket = "ahmed-state-terraform-yat"
        key = "dev/terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "terraform-up-and-running-locks"
        encrypt = true
    }
}

resource "aws_s3_bucket" "terraform-state" {
    bucket = "ahmed-state-terraform-yat"
    lifecycle {
      prevent_destroy = true
    }
}

resource "aws_s3_bucket_versioning" "s3-enable-versioning" {
  bucket = "ahmed-state-terraform-yat"
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform-lock-table" {
  name = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

}

