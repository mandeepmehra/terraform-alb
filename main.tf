resource "aws_alb" "name" {
  name            = "MyALB"
  internal        = false
  security_groups = [aws_security_group.albsg.id]
  subnets         = ["subnet-0105aa6b9327f5cc1", "subnet-019f73092e25c1591"]
}


resource "aws_security_group" "albsg" {
  name   = "albsg"
  vpc_id = "vpc-03f094db73a5298e9"
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

