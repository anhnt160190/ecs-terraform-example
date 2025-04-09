locals {
  env              = "dev"
  aws_account_id   = "6152012730594"
  region           = "ap-southeast-1"
  vpc_cidr         = "10.3.0.0/16"
  private_subnets  = ["10.3.1.0/24", "10.3.2.0/24", "10.3.3.0/24"]
  public_subnets   = ["10.3.4.0/24", "10.3.5.0/24", "10.3.6.0/24"]
  azs              = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  ecs_cluster_name = "demo"
  lb_name          = "demo"
  root_domain_name = "demo-ecs.anhnt160190.com"
  container_port   = 4000
}
