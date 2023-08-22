################################################################################
# ALB Security Group
################################################################################
resource "aws_security_group" "alb-sg" {
  vpc_id = aws_vpc.yhj-vpc.id
  name = "${var.alb-sg-name}"
  description = "${var.alb-sg-name}"

  tags = {"Name"="${var.alb-sg-name}"}
}

# 인바운드 규칙 추가 
resource "aws_security_group_rule" "alb-sg-Inbound-http" {
  security_group_id = aws_security_group.alb-sg.id
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "TCP"
  cidr_blocks = ["0.0.0.0/0"]
}

# 아웃바운드 규칙 추가
resource "aws_security_group_rule" "alb-sg-outbound" {
  security_group_id = aws_security_group.alb-sg.id
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = ["0.0.0.0/0"]
}

################################################################################
# Application Load Balancer
################################################################################
resource "aws_lb" "alb" {
  name = "${var.public-alb-name}"
  internal = false
  load_balancer_type = "application"
  subnets = [aws_subnet.public-subnet-2a.id, aws_subnet.public-subnet-2c.id, aws_subnet.public-subnet-2d.id]
  security_groups = [aws_security_group.alb-sg.id]

}

################################################################################
# Target Group
################################################################################
resource "aws_lb_target_group" "alb-tg" {
  name = "${var.alb-tg-name}"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.yhj-vpc.id
}

resource "aws_lb_target_group_attachment" "alb-tg-ec2-1" {
  target_group_arn = aws_lb_target_group.alb-tg.arn
  target_id = aws_instance.app_server-1.id
  port = 80
}

resource "aws_lb_target_group_attachment" "alb-tg-ec2-2" {
  target_group_arn = aws_lb_target_group.alb-tg.arn
  target_id = aws_instance.app_server-2.id
  port = 80
}

# resource "aws_lb_target_group_attachment" "alb-tg-ec2-3" {
#   target_group_arn = aws_lb_target_group.alb-tg.arn
#   target_id = aws_instance.app_server-3.id
#   port = 80
# }