locals {
  container_name     = "${var.env}-${var.service_name}"
  docker_image       = "${var.image_name}:${var.image_tag}"
  ecs_log_group_name = "/ecs/${var.ecs_cluster_name}/${local.container_name}"
  is_public          = length(var.host_header) > 0
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  count             = var.enabled_log ? 1 : 0
  name              = local.ecs_log_group_name
  retention_in_days = var.log_retention
}

resource "aws_ecs_task_definition" "task_definition" {
  family             = local.container_name
  cpu                = var.cpu
  memory             = var.memory
  execution_role_arn = var.ecs_task_role
  task_role_arn      = var.ecs_task_role
  network_mode       = "awsvpc"

  container_definitions = jsonencode([
    {
      name        = local.container_name
      image       = local.docker_image
      cpu         = var.cpu
      memory      = var.memory
      essential   = true
      secrets     = var.env_secrets
      environment = var.envs
      tags = {
        env = var.env
      }
      portMappings = [
        {
          containerPort = var.port
          hostPort      = var.port
          name          = "tcp-${var.port}"
          protocol      = "tcp"
        }
      ]
      logConfiguration = var.enabled_log ? {
        "logDriver" = "awslogs",
        "options" = {
          "awslogs-create-group"  = "true",
          "awslogs-group"         = local.ecs_log_group_name,
          "awslogs-stream-prefix" = "ecs"
          "awslogs-region"        = var.region,
        },
      } : null
    }
  ])
}

resource "aws_ecs_service" "ecs_service" {
  name                   = local.container_name
  cluster                = var.ecs_cluster_arn
  task_definition        = aws_ecs_task_definition.task_definition.arn
  desired_count          = var.desired_count
  enable_execute_command = true
  depends_on             = [aws_ecs_task_definition.task_definition]

  dynamic "load_balancer" {
    for_each = local.is_public ? [true] : []
    content {
      target_group_arn = aws_lb_target_group.target_group[0].arn
      container_name   = local.container_name
      container_port   = var.port
    }
  }

  network_configuration {
    security_groups  = var.sg_ids
    subnets          = var.private_subnets
    assign_public_ip = false
  }

  capacity_provider_strategy {
    capacity_provider = var.capacity_provider
    weight            = 1
    base              = 0
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  lifecycle {
    ignore_changes = [
      desired_count,
    ]
  }
}


resource "aws_lb_target_group" "target_group" {
  count       = local.is_public ? 1 : 0
  name        = substr("ecs-${local.container_name}", 0, 32)
  port        = var.port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path    = var.health_check_path
    matcher = "200-299"
  }
}

resource "aws_lb_listener_rule" "host_header_rule" {
  count        = local.is_public ? 1 : 0
  listener_arn = var.alb_https_listener_arn
  priority     = var.rule_priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group[0].arn
  }

  condition {
    host_header {
      values = var.host_header
    }
  }
}
