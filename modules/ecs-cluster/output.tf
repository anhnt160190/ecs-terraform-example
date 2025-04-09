output "ecs_cluster_name" {
  value = aws_ecs_cluster.cluster.name
}
output "ecs_cluster_arn" {
  value = aws_ecs_cluster.cluster.arn
}
output "ecs_task_role_arn" {
  value = aws_iam_role.task_role.arn
}
output "eventbridge_role_arn" {
  value = aws_iam_role.eventbridge_role.arn
}
