variable "aws_region" {
  type        = string
  default     = "eu-west-1"
  description = "AWS region for the S3 bucket"
}

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "policy_demo_tag" {
  type        = string
  default     = "managed-by-terraform"
  description = "Tag value used to demo policy/drift detection"
}
