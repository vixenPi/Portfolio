resource "aws_lb" "alexs_lb" {
  name               = "alexs-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alexs_sg_bc.id]
  subnets            = [aws_subnet.subnet_0.id, aws_subnet.subnet_1.id]

  enable_deletion_protection = false

  tags = {
    Environment = "testing"
  }
}

resource "aws_lb_listener" "alexs-listener" {
  load_balancer_arn = aws_lb.alexs_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alexs-page.arn
  }
}

resource "aws_lb_target_group" "alexs-page" {
  name     = "alexs-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check{
    path   = "/health-check"
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}
