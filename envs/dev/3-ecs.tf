module "ecs_cluster" {
  source         = "../../modules/ecs-cluster"
  env            = local.env
  aws_account_id = local.aws_account_id
  region         = local.region
  cluster_name   = local.ecs_cluster_name
}

resource "aws_security_group" "ecs_service_sg" {
  name       = "${local.env}-ecs-service-sg"
  vpc_id     = module.vpc.vpc_id
  depends_on = [module.vpc]

  ingress {
    from_port   = local.container_port
    to_port     = local.container_port
    protocol    = "tcp"
    security_groups = [module.alb.alb_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.env}-ecs-service-sg"
  }
}
