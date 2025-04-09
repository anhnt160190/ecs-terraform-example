variable "env" {
  type = string
}
variable "aws_account_id" {
  type = string
}
variable "region" {
  type = string
}
variable "bucket_name" {
  type = string
}
variable "enabled_encrypt" {
  type    = bool
  default = true
}
variable "enabled_versioning" {
  type    = bool
  default = true
}
variable "bucket_policy" {
  type    = string
  default = null
}
