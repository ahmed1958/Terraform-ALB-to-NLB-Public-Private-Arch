# terraform {
#   backend "s3" {
#     bucket         = "terraform-state-file-yat"
#     key            = "terraform/state"
#     region         = "us-east-1"
#     dynamodb_table = "terraform-locks"
#   }
# }