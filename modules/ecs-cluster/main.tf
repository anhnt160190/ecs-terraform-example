resource "aws_ecs_cluster" "cluster" {
  name = "${var.env}-${var.cluster_name}"
}

resource "aws_iam_role" "task_role" {
  name = "${var.env}-${var.cluster_name}-task-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "task_role_policy" {
  role       = aws_iam_role.task_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ADD CUSTOM POLICIES HERE
resource "aws_iam_role_policy" "custom_task_policy" {
  name = "${var.env}-${var.cluster_name}-task-read-secret"
  role = aws_iam_role.task_role.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["secretsmanager:GetSecretValue"]
        Effect   = "Allow"
        Resource = ["arn:aws:secretsmanager:${var.region}:${var.aws_account_id}:secret:${var.env}-${var.cluster_name}*"]
      },
      {
        Action   = ["s3:PutObject"]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::${var.env}-${var.cluster_name}-media/*"]
      },
      {
        Action   = ["ses:SendEmail"]
        Effect   = "Allow"
        Resource = ["*"]
      }
    ]
  })
}

# ROLE TO TRIGGER CRON JOBS
resource "aws_iam_role" "eventbridge_role" {
  name = "${var.env}-${var.cluster_name}-eventbridge-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "eventbridge_policy" {
  name = "${var.env}-${var.cluster_name}-eventbridge-policy"
  role = aws_iam_role.eventbridge_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecs:RunTask"
        ]
        Resource = ["*"]
      },
      {
        Effect = "Allow"
        Action = [
          "iam:PassRole"
        ]
        Resource = ["*"]
      }
    ]
  })
}
