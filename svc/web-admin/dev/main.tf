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
    key    = "s3/infra/svc/web-admin/envs/dev.tfstate"
    region = "ap-southeast-1"
  }
}

module "base" {
  source = "../base"
  env = local.env
  aws_account_id = local.aws_account_id
  region = local.region
  bucket_name = local.bucket_name
  enabled_encrypt = local.enabled_encrypt
  enabled_versioning = local.enabled_versioning
  domain_name = local.domain_name
  acm_certificate_arn = local.acm_certificate_arn
}
