resource "aws_alb" "name" {
  name            = "MyALB"
  internal        = false
  security_groups = [aws_security_group.albsg.id]
  subnets         = ["subnet-0105aa6b9327f5cc1", "subnet-019f73092e25c1591"]
}


resource "aws_security_group" "albsg" {
  name   = "albsg"
  vpc_id = var.vpc_id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }
}

resource "aws_lb_target_group" "myalbtg" {
  name     = "myalb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_alb.name.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.myalbtg.arn
  }
}