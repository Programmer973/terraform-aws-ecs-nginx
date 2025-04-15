output "cluster_id" {
    description = "the ecs cluster id"
    value       = aws_ecs_cluster.this.id
  
}

output "service_name" {
    description = "the ecs service name"
    value       = aws_ecs_service.this.name
  
}

output "task_definition_arn" {
    description = "the ecs task definition arn"
    value       = aws_ecs_task_definition.this.arn
  
}

output "ecs_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}
