output "ecr_name" {
  value = aws_ecr_repository.repo.name
}

output "ecr_arn" {
  value = aws_ecr_repository.repo.arn
}

output "ecr_repo_url" {
  value = aws_ecr_repository.repo.repository_url
}
