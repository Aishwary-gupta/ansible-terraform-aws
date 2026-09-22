locals {
  # AWS Load Balancer and Target Group names must be <= 32 characters
  alb_name = substr("${var.project_name}-${var.environment}-alb", 0, 32)
  tg_name  = substr("${var.project_name}-${var.environment}-tg", 0, 32)
}

# Application Load Balancer
resource "aws_lb" "main" {
  name               = local.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = local.alb_name
  }
}

# Target Group for Web Application
resource "aws_lb_target_group" "main" {
  name        = local.tg_name
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    enabled             = true
    path                = var.health_check_path
    port                = "traffic-port"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  tags = {
    Name = local.tg_name
  }
}

# HTTP Listener (Forward to Target Group)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}