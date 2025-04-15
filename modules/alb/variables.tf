variable "name" {
  type = string
  description = "Name prefix for ALB resources"
}

variable "vpc_id" {
  type = string
  description = "VPC ID to associate the ALB and security group"
}

variable "public_subnet_ids" {
  type = list(string)
  description = "List of public subnet IDs for ALB deployment"
}
