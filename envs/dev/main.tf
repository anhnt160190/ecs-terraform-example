provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${local.aws_account_id}:role/TF_ROLE"
  }
  region = local.region
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${local.aws_account_id}:role/TF_ROLE"
  }
  alias  = "ue1"
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "s3-infra-dev"
    key    = "s3/infra/envs/dev.tfstate"
    region = "ap-southeast-1"
  }
}
