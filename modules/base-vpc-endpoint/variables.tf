variable "env" {
  type = string
}
variable "aws_account_id" {
  type = string
}
variable "region" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "private_subnets" {
  type = list(string)
}
variable "private_route_table_ids" {
  type = list(string)
}
variable "whitelist_sg_ids" {
  type    = list(string)
  default = []
}
