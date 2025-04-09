module "alb" {
  source              = "../../modules/load-balancer"
  env                 = local.env
  aws_account_id      = local.aws_account_id
  region              = local.region
  lb_name             = local.lb_name
  public_subnets      = module.vpc.public_subnets
  acm_certificate_arn = module.acm.acm_certificate_arn
  vpc_id              = module.vpc.vpc_id
  depends_on          = [module.vpc, module.acm]
}
