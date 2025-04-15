resource "aws_lb" "this" {
    name                = "${var.name}-alb"
    internal            = false
    load_balancer_type  = "application"
    subnets             = var.public_subnet_ids
    security_groups      = [aws_security_group.alb.id]

    tags = {
      Name = "${var.name}-alb"
    }
  
}

resource "aws_security_group" "alb" {
    name ="${var.name}-alb-sg"
    description = "Allow HTTP and HTTPS traffic"
    vpc_id = var.vpc_id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
        Name = "${var.name}-alb-sg"
    }
  
}

resource "aws_lb_target_group" "this" {
    name     = "${var.name}-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
    target_type = "ip"

    health_check {
        path = "/"
        protocol = "HTTP"
        matcher = "200"
        interval = 30
        timeout = 5
        healthy_threshold = 2
        unhealthy_threshold = 2
    }
    tags = {
      Name = "${var.name}-tg"
    }
  
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.this.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.this.arn
    }
}

