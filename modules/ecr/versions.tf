terraform {
  required_providers {
    aws = {
      version = ">= 5.0.0"
      source  = "hashicorp/aws"
    }
  }
  required_version = ">= 1.7.5"
}
