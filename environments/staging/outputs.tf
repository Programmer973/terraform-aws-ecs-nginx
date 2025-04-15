output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "alb_dns_name" {
  description = "Public DNS name of the ALB"
  value = module.alb.alb_dns_name 
  
}

output "target_group_arn" {
  description = "ARN of the target group to register ECS tasks"
  value = module.alb.alb_target_group_arn
  
}