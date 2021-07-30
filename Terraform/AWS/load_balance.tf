resource "aws_lb_target_group" "tgIAC" {
  name             = "tgIAC"
  vpc_id           = aws_vpc.vpc_iac.id
  port             = 80
  protocol         = "HTTP"
  protocol_version = "HTTP1"
  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = 200
    port                = "traffic-port"
    path                = "/"
    unhealthy_threshold = 2
    timeout             = 20
  }
}

resource "aws_lb_target_group_attachment" "attach_instance" {
  depends_on = [
    aws_instance.server
  ]
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.tgIAC.arn
  target_id        = aws_instance.server[count.index].id
  port             = 80
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb_iac.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tgIAC.arn
  }
}

resource "aws_lb" "lb_iac" {
  depends_on = [
    aws_vpc.vpc_iac
  ]
  name               = "lbiac"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_vpc_iac_load_balance.id]
  subnets            = aws_subnet.sub_iac_publ.*.id

  enable_deletion_protection = false


  tags = {
    Environment = var.env["producao"]
  }
}