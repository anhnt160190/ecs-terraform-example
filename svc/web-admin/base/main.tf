data "aws_iam_policy_document" "bucket_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${var.env}-${var.bucket_name}/*",
      "arn:aws:s3:::${var.env}-${var.bucket_name}"
    ]
  }
}

module "s3_bucket" {
  source             = "../../../modules/s3-bucket"
  env                = var.env
  aws_account_id     = var.aws_account_id
  region             = var.region
  bucket_name        = var.bucket_name
  enabled_encrypt    = var.enabled_encrypt
  enabled_versioning = var.enabled_versioning
  bucket_policy      = data.aws_iam_policy_document.bucket_policy.json
}

module "cloudfront" {
  source                             = "../../../modules/cloudfront"
  env                                = var.env
  aws_account_id                     = var.aws_account_id
  region                             = var.region
  domain_name                        = var.domain_name
  acm_certificate_arn                = var.acm_certificate_arn
  bucket_name                        = module.s3_bucket.bucket_name
  bucket_regional_domain_name        = module.s3_bucket.bucket_regional_domain_name
  depends_on                         = [module.s3_bucket]
}
