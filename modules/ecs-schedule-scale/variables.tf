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
variable "scale_down_night_schedule" {
  type    = string
  default = "cron(0 12 ? * MON-FRI *)"
}
variable "scale_up_morning_schedule" {
  type    = string
  default = "cron(0 1 ? * MON-FRI *)"
}
