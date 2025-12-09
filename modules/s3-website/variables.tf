variable "demo_message" {
  type    = string
  default = "Hello from Terraform!"
}

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "aws_region" {
  type        = string
  description = "AWS region for the bucket"
}

variable "policy_demo_tag" {
  type        = string
  default     = "managed-by-terraform"
  description = "Tag value you can change to simulate drift"
}
