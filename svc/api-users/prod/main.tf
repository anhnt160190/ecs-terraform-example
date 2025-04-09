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
    bucket = "s3-infra-prod"
    key    = "s3/infra/svc/api-users/envs/prod.tfstate"
    region = "ap-southeast-1"
  }
}

module "base" {
  source                 = "../base"
  env                    = local.env
  aws_account_id         = local.aws_account_id
  region                 = local.region
  ecr_name               = local.ecr_name
  ecs_task_role_arn      = local.ecs_task_role_arn
  service_name           = local.service_name
  ecs_cluster_arn        = local.ecs_cluster_arn
  ecs_cluster_name       = local.ecs_cluster_name
  alb_https_listener_arn = local.alb_https_listener_arn
  vpc_id                 = local.vpc_id
  private_subnets        = local.private_subnets
  port                   = local.container_port
  sg_ids                 = local.sg_ids
  rule_priority          = local.rule_priority
  host_header            = local.host_header
  envs = [
    { "name" = "SERVER_PORT", "value" = local.container_port }
  ]
  env_secrets = [
    { "name" = "MONGODB_URI", "valueFrom" = "${local.secret_manager_arn}:MONGODB_URI::" }
  ]
}

module "ecs_auto_scaling" {
  source         = "../../../modules/ecs-auto-scaling"
  env            = local.env
  aws_account_id = local.aws_account_id
  region         = local.region
  service_name   = "${local.env}-${local.service_name}"
  max_capacity   = 10
  min_capacity   = 2
  resource_id    = "service/${local.env}-${local.ecs_cluster_name}/${local.env}-${local.service_name}"
  depends_on     = [module.ecs_service]
}
