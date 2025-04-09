module "vpc" {
  source          = "../../modules/vpc"
  env             = local.env
  aws_account_id  = local.aws_account_id
  region          = local.region
  vpc_cidr        = local.vpc_cidr
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets
  azs             = local.azs
}

module "base_vpc_endpoint" {
  source                  = "../../modules/base-vpc-endpoint"
  env                     = local.env
  aws_account_id          = local.aws_account_id
  region                  = local.region
  vpc_cidr                = module.vpc.vpc_cidr
  vpc_id                  = module.vpc.vpc_id
  private_subnets         = module.vpc.private_subnets
  private_route_table_ids = module.vpc.private_route_table_ids
  whitelist_sg_ids        = []
  depends_on              = [module.vpc]
}
