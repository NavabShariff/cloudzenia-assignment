#alb


# Target Groups
resource "aws_lb_target_group" "instance1_tg" {
  name     = "instance1-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"

  health_check {
    path     =  "/"
    port     = "80"
    protocol = "HTTP"
    matcher  = "200"
  }
}

resource "aws_lb_target_group" "instance2_tg" {
  name     = "instance2_tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path     =  "/"
    port     = "80"
    protocol = "HTTP"
    matcher  = "200"
  }
}

# ACM Certificate
data "aws_acm_certificate" "cert" {
  domain      = "*.shariff.info"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}


data "aws_lb_listener" "https_listener" {
  load_balancer_arn = var.aws_alb_arn
  port              = 443
}



# Listener Rules

resource "aws_alb_listener_rule" "elb_instance_rule" {
  listener_arn = data.aws_lb_listener.https_listener.arn
  priority     = "10"

  condition {
    host_header {
      values = [var.elb_instance_domain]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.instance1_tg.arn
  }
}

resource "aws_alb_listener_rule" "elb_docker_rule" {
  listener_arn = data.aws_lb_listener.https_listener.arn
  priority     = "10"

  condition {
    host_header {
      values = [var.elb_docker_domain]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.instance2_tg.arn
  }
}