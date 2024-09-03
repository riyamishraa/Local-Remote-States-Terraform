# Specify the Terraform provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "eu-north-1"  # Replace with your desired region
}

# Define the AWS EC2 instance
resource "aws_instance" "my_instance" {
  ami           = "ami-0c232c9952bd4be59"  # Replace with the AMI ID for your region
  instance_type = "t3.micro"

  # Optional: Add tags
  tags = {
    Name = "MyTerraformInstance"
  }
}
