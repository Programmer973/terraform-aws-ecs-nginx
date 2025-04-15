output "alb_arn" {
  description = "The ARN of the application load balancer"
  value       = aws_lb.this.arn
  
}
output "alb_dns_name" {
  description = "Public DNS name of the ALB obviously"
  value       = aws_lb.this.dns_name
  
}

output "alb_target_group_arn" {
  description = "ARN of the target group to register ECS tasks"
  value       = aws_lb_target_group.this.arn
  
}

output "target_group_arn" {
  description = "The ARN of the ALB target group"
  value       = aws_lb_target_group.this.arn
}

output "alb_sg_id" {
  description = "The ALB security group ID"
  value       = aws_security_group.alb.id
}
output "security_group_id" {
  value = aws_security_group.alb.id
}



output "alb_security_group_id" {
  description = "The security group ID of the ALB"
  value       = aws_security_group.alb.id
}

