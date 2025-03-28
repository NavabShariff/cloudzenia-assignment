provider "aws" {
  region  = var.region
  profile = var.profile
}



# alb
resource "aws_lb" "application_load_balancer" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_sg_id
  subnets            = var.public_subnet_ids
}


# Target Groups
resource "aws_lb_target_group" "wordpress_tg" {
  name     = var.wordpress_target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path     = var.wordpress_health_check_path
    port     = "80"
    protocol = "HTTP"
    matcher  = "200-399"
  }
}

resource "aws_lb_target_group" "microservice_tg" {
  name     = var.microservice_target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path     = var.microservice_health_check_path
    port     = "3000"
    protocol = "HTTP"
    matcher  = "200"
  }
}

# ACM Certificate
data "aws_acm_certificate" "cert" {
  domain      = var.certificate_domain
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}


# HTTPS Listener (Fix the redirect issue)

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress_tg.arn
  }
}


# HTTP Listener (Redirect to HTTPS)

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}




# Listener Rules

resource "aws_alb_listener_rule" "wordpress_rule" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = var.wordpress_priority

  condition {
    host_header {
      values = [var.wordpress_domain]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress_tg.arn
  }
}

resource "aws_alb_listener_rule" "microservice_rule" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = var.microservice_priority

  condition {
    host_header {
      values = [var.microservice_domain]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.microservice_tg.arn
  }
}