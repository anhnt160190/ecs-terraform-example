variable "env" {
  type = string
}
variable "aws_account_id" {
  type = string
}
variable "region" {
  type = string
}
variable "ecr_name" {
  type = string
}
variable "ecs_task_role_arn" {
  type = string
}
variable "log_retention" {
  type    = number
  default = 7
}
variable "enabled_log" {
  type    = bool
  default = true
}
variable "service_name" {
  type = string
}
variable "cpu" {
  type    = number
  default = 256
}
variable "memory" {
  type    = number
  default = 512
}
variable "image_version" {
  type    = string
  default = "latest"
}
variable "port" {
  type    = number
  default = 4000
}
variable "envs" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}
variable "env_secrets" {
  type = list(object({
    name      = string
    valueFrom = string
  }))
  default = []
}
variable "health_check_path" {
  type    = string
  default = "/ping"
}
variable "ecs_cluster_arn" {
  type = string
}
variable "ecs_cluster_name" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "alb_https_listener_arn" {
  type = string
}
variable "private_subnets" {
  type = list(string)
}
variable "sg_ids" {
  type = list(string)
}
variable "rule_priority" {
  type = number
}
variable "host_header" {
  type = list(string)
}
variable "desired_count" {
  type    = number
  default = 1
}
variable "capacity_provider" {
  type    = string
  default = "FARGATE_SPOT"
}
