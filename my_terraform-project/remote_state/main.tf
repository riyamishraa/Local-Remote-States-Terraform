# ------------------------------------------------------------------------------
# CONFIGURE THE TERRAFORM BACKEND (S3 + DynamoDB)
# ------------------------------------------------------------------------------

terraform {
  backend "s3" {
    bucket         = "022499024191-terraform-states"   # Existing S3 bucket
    key            = "terraform.tfstate"                # State file path within the bucket
    region         = "us-west-2"                         # AWS region for the bucket and table
    dynamodb_table = "terraform-lock"                    # Existing DynamoDB table for state locking
    encrypt        = true                               # Enable server-side encryption
  }

  required_version = ">= 0.12"
}

# ------------------------------------------------------------------------------
# CONFIGURE OUR AWS CONNECTION
# ------------------------------------------------------------------------------

provider "aws" {
  region = "us-west-2"  # AWS region where the bucket and table are located
}

# ------------------------------------------------------------------------------
# CREATE THE S3 BUCKET
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "terraform_state" {
  bucket = "022499024191-terraform-states"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# ------------------------------------------------------------------------------
# CREATE THE DYNAMODB TABLE
# ------------------------------------------------------------------------------

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
