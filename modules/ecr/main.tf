resource "aws_ecr_repository" "repo" {
  name                 = var.ecr_name
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  repository = aws_ecr_repository.repo.name
  depends_on = [aws_ecr_repository.repo]

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 5 images"
        selection = {
          "tagStatus" : "tagged",
          "tagPrefixList" : ["v"],
          "countType" : "imageCountMoreThan",
          "countNumber" : 5
        }
        action = {
          type = "expire"
        }
      },
    ]
  })
}
