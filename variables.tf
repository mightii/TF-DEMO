variable "aws_region" {
  type        = string
  default     = "eu-west-1"
  description = "AWS region for the S3 bucket"
}

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}
