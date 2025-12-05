variable "bucket_name" {
  type = string
}

variable "aws_region" {
  type = string
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "demo_block" {
  bucket = aws_s3_bucket.demo_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "bucket_id" {
  value = aws_s3_bucket.demo_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.demo_bucket.arn
}