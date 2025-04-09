variable "env" {
  type = string
}
variable "aws_account_id" {
  type = string
}
variable "region" {
  type = string
}
variable "domain_name" {
  type = string
}
variable "bucket_name" {
  type = string
}
variable "bucket_regional_domain_name" {
  type = string
}
variable "acm_certificate_arn" {
  type = string
}
variable "default_cache_function_association" {
  type    = string
  default = null
}
