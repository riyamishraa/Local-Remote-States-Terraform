output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
}

output "s3_bucket_region" {
  value = aws_s3_bucket.terraform_state.region
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_lock.name
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.terraform_lock.arn
}
