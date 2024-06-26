resource "aws_lb" "main" {
  name               = "${var.config.projectName}-alb-${var.config.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.securityGroupIds
  subnets            = var.subnetIds

  enable_deletion_protection = false

  tags = {
    Name = "${var.config.projectName}-alb-${var.config.environment}"
  }
}

resource "aws_lb_target_group" "main" {
  name     = "${var.config.projectName}-tg-${var.config.environment}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  tags = {
    Name = "${var.config.projectName}-tg-${var.config.environment}"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}
