terraform {
  required_providers {
    aws = {
      version               = ">= 5.0.0"
      source                = "hashicorp/aws"
      configuration_aliases = [aws.ue1]
    }
  }
  required_version = ">= 1.7.5"
}
