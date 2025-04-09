module "ecr_service" {
  source         = "../../../modules/ecr"
  env            = var.env
  aws_account_id = var.aws_account_id
  region         = var.region
  ecr_name       = var.ecr_name
}

module "ecs_service" {
  source                 = "../../../modules/ecs-service"
  env                    = var.env
  aws_account_id         = var.aws_account_id
  region                 = var.region
  ecs_task_role          = var.ecs_task_role_arn
  log_retention          = var.log_retention
  enabled_log            = var.enabled_log
  service_name           = var.service_name
  cpu                    = var.cpu
  memory                 = var.memory
  image_name             = module.ecr_api_service.ecr_repo_url
  image_tag              = var.image_version
  port                   = var.port
  env_secrets            = var.env_secrets
  envs                   = var.envs
  health_check_path      = var.health_check_path
  ecs_cluster_arn        = var.ecs_cluster_arn
  vpc_id                 = var.vpc_id
  alb_https_listener_arn = var.alb_https_listener_arn
  private_subnets        = var.private_subnets
  sg_ids                 = var.sg_ids
  rule_priority          = var.rule_priority
  host_header            = var.host_header
  ecs_cluster_name       = var.ecs_cluster_name
  capacity_provider      = var.capacity_provider
  desired_count          = var.desired_count
  depends_on             = [module.ecr_service]
}
