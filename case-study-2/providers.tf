terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.0"
    }
  }
}

provider "aws" {
  region = "eu-south-1"
  default_tags {
    tags = {
      Project = "Case Study 2"
    }
  }
}