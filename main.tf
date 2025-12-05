terraform {
  cloud {
    organization = "acme-cloud20"         # Mets le nom de ton org TFC
    workspaces {
      name = "acme-website-dev"           # Le workspace que tu vas utiliser
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "demo_s3" {
  source      = "./modules/s3-website"
  bucket_name = var.bucket_name
  aws_region  = var.aws_region
}
