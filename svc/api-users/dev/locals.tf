locals {
  env                    = "dev"
  aws_account_id         = "6152012730594"
  region                 = "ap-southeast-1"
  ecr_name               = "api-users"
  ecs_task_role_arn      = "arn:aws:iam::6152012730594:role/dev-demo-task-role"
  service_name           = "api-users"
  ecs_cluster_arn        = "arn:aws:ecs:ap-southeast-1:6152012730594:cluster/dev-demo"
  ecs_cluster_name       = "demo"
  alb_https_listener_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:6152012730594:listener/app/demo-alb/4123456789abcdef/4123456789abcdef"
  vpc_id                 = "vpc-0123456789abcdef"
  alb_sg_id              = "sg-0123456789abcdef"
  private_subnets        = ["subnet-0123456789abcdef", "subnet-0123456789abcdef", "subnet-0123456789abcdef"]
  lb_name                = "demo"
  root_domain_name       = "demo-ecs.anhnt160190.com"
  secret_manager_arn     = "arn:aws:secretsmanager:ap-southeast-1:6152012730594:secret:dev-api-users-sSZCnP"
  container_port         = 4000
  rule_priority          = 1
  host_header            = ["${local.env}-${local.service_name}.${local.root_domain_name}"]
  sg_ids                 = ["sg-0123456789abcdef"]
}
