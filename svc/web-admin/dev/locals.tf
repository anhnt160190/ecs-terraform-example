locals {
  env                    = "dev"
  aws_account_id         = "6152012730594"
  region                 = "ap-southeast-1"
  bucket_name            = "web-admin"
  enabled_encrypt        = true
  enabled_versioning     = true
  domain_name            = "dev-web-admin.demo-ecs.anhnt160190.com"
  acm_certificate_arn    = "arn:aws:acm:us-east-1:6152012730594:certificate/12345678-1234-1234-1234-123456789012"
}
