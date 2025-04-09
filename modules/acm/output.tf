output "acm_certificate_arn" {
  value = aws_acm_certificate.acm_cert.arn
}

output "domain_name" {
  value = aws_acm_certificate.acm_cert.domain_name
}
