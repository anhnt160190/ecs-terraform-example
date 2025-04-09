variable "env" {
  type = string
}
variable "aws_account_id" {
  type = string
}
variable "region" {
  type = string
}
variable "ecs_task_role" {
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
variable "host_header" {
  type    = list(string)
  default = []
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
variable "env_secrets" {
  type = list(object({
    name      = string
    valueFrom = string
  }))
  default = []
}
variable "envs" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}
variable "image_name" {
  type = string
}
variable "image_tag" {
  type    = string
  default = "latest"
}
variable "port" {
  type = number
}
variable "health_check_path" {
  type    = string
  default = "/"
}
variable "rule_priority" {
  type    = number
  default = 1
}
variable "ecs_cluster_name" {
  type = string
}
variable "ecs_cluster_arn" {
  type = string
}
variable "desired_count" {
  type    = number
  default = 1
}
variable "capacity_provider" {
  type    = string
  default = "FARGATE_SPOT"
}
variable "vpc_id" {
  type = string
}
variable "private_subnets" {
  type = list(string)
}
variable "alb_https_listener_arn" {
  type = string
}
variable "sg_ids" {
  type    = list(string)
  default = []
}
