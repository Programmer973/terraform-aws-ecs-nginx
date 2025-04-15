variable "name" {
    description = "Nmae prefix for ECS resources"
    type        = string
  
}

variable "vpc_id" {
    description = "the id of the vpc where ECS will be deployed"    
    type        = string
  
}
variable "public_subnet_ids" {
    description = "List of private subnet IDs for ECS deployment"
    type        = list(string)
  
}
variable "target_group_arn" {
    description = "Alb target group arn to register ECS tasks to"
    type        = string
  
}

variable "ecs_execution_role_arn" {
    description = "IAM role arn tha ecs tasks will use to pull images and log to cloudwatch"
    type        = string
  
}
variable "alb_security_group_id" {
    description = "Alb security group id to allow traffic from alb to ECS tasks"
    type        = string
  
}

