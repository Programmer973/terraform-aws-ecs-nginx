resource "aws_ecs_cluster" "this" {
    name = "${var.name}-ecs-cluster"
  
}

resource "aws_ecs_task_definition" "this" {
    family = "${var.name}-nginx-task"
    network_mode = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu = "256"
    memory = "512"
    execution_role_arn = var.ecs_execution_role_arn

    container_definitions = jsonencode([
        {
            name = "nginx"
            image = "nginx:latest"
            essential = true
            portMappings = [
                {
                    containerPort = 80
                    hostPort = 80
                    protocol = "tcp"
                }
            ]
        }
    ])
  
}

resource "aws_ecs_service" "this" {
    name = "${var.name}-nginx-service"
    cluster = aws_ecs_cluster.this.id
    task_definition = aws_ecs_task_definition.this.arn
    desired_count = 2
    launch_type = "FARGATE"

    network_configuration {
    subnets         = var.public_subnet_ids
    assign_public_ip = true  
    security_groups = [aws_security_group.ecs.id]
    }   


    load_balancer {
        target_group_arn = var.target_group_arn
        container_name   = "nginx"
        container_port   = 80
    }
    
}

#resource "aws_lb_target_group_attachment" "this" {
#  target_group_arn = var.target_group_arn
#  target_id        = aws_ecs_service.this.id
#  port             = 80
#}




resource "aws_security_group" "ecs" {
    name = "${var.name}-ecs-sg"
    vpc_id = var.vpc_id

   ingress {
   from_port       = 80
   to_port         = 80
   protocol        = "tcp"
   security_groups = [var.alb_security_group_id]
   }


    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
    
     tags = {
        Name = "${var.name}-ecs-sg"
     }
}