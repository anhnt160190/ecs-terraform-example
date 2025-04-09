module "acm" {
  source         = "../../modules/acm"
  env            = local.env
  aws_account_id = local.aws_account_id
  region         = local.region
  domain_name    = local.root_domain_name
}

module "acm_ue1" {
  source         = "../../modules/acm"
  env            = local.env
  aws_account_id = local.aws_account_id
  region         = "us-east-1"
  domain_name    = local.root_domain_name
  providers = {
    aws = aws.ue1
  }
}
