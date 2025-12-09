provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = var.bucket_name

  tags = {
    Owner          = "Terraform"
    PolicyDemoTag  = var.policy_demo_tag
    Purpose        = "tfc-demo"
  }
}

resource "aws_s3_bucket_public_access_block" "demo_block" {
  bucket = aws_s3_bucket.demo_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "demo_message" {
  bucket  = aws_s3_bucket.demo_bucket.id
  key     = "message.txt"
  content = var.demo_message
  # This makes sure Terraform detects changes to content reliably
  etag = md5(var.demo_message)
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid     = "EnforceTLS"
    effect  = "Deny"
    actions = ["s3:*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    resources = [
      aws_s3_bucket.demo_bucket.arn,
      "${aws_s3_bucket.demo_bucket.arn}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }

  statement {
    sid     = "DenyUnencryptedUploads"
    effect  = "Deny"
    actions = ["s3:PutObject"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    resources = ["${aws_s3_bucket.demo_bucket.arn}/*"]
    condition {
      test     = "Null"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["true"]
    }
  }
}

resource "aws_s3_bucket_policy" "demo_policy" {
  bucket = aws_s3_bucket.demo_bucket.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

output "bucket_id" {
  value = aws_s3_bucket.demo_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.demo_bucket.arn
}
