variable "env" {
  type = string
}
variable "aws_account_id" {
  type = string
}
variable "region" {
  type = string
}
variable "service_name" {
  type = string
}
variable "max_capacity" {
  type = number
}
variable "min_capacity" {
  type = number
}
variable "resource_id" {
  type = string
}
variable "cpu_target_value" {
  type        = number
  description = "Target CPU utilization percentage"
  default     = 80
}
variable "memory_target_value" {
  type        = number
  description = "Target Memory utilization percentage"
  default     = 80
}
variable "scale_in_cooldown" {
  type        = number
  description = "Time (in seconds) between scale in actions"
  default     = 300
}
variable "scale_out_cooldown" {
  type        = number
  description = "Time (in seconds) between scale out actions"
  default     = 300
}
