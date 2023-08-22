################################################################################
# EC2 Security Group
################################################################################
resource "aws_security_group" "yhjec2-SG" {
  vpc_id = aws_vpc.yhj-vpc.id
  name = "${var.ec2-sg-name}"
  description = "${var.ec2-sg-name}"

  tags = {"Name"="${var.ec2-sg-name}"}
}

# 인바운드 규칙 추가 
resource "aws_security_group_rule" "ec2-alb-Inbound-http" {
  security_group_id = aws_security_group.yhjec2-SG.id
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "TCP"
  cidr_blocks = [aws_security_group.alb-sg.id]
}

resource "aws_security_group_rule" "ec2-bastion-Inbound-http" {
  security_group_id = aws_security_group.yhjVPC-SecurityGroup.id
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "TCP"
  cidr_blocks = [aws_security_group.yhjVPC-SecurityGroup.id]
}

resource "aws_security_group_rule" "ec2-bastion-Inbound-ssh" {
  security_group_id = aws_security_group.yhjVPC-SecurityGroup.id
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "TCP"
  cidr_blocks = [aws_security_group.yhjVPC-SecurityGroup.id]
}

# 아웃바운드 규칙 추가
resource "aws_security_group_rule" "securityGroupOutbound" {
  security_group_id = aws_security_group.yhjVPC-SecurityGroup.id
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = ["0.0.0.0/0"]
}

################################################################################
# EC2 instance
################################################################################
resource "aws_instance" "app_server-1" {
  ami           = "ami-0c9c942bd7bf113a2"
  instance_type = "t2.micro"
  key_name = "${var.keyName}"
  subnet_id = aws_subnet.private-northeast-2a.id
  security_groups = [aws_security_group.yhjec2-SG]
  user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p ${var.server_port} &
                EOF
  tags = {"Name"="${var.instance-1-name}"}
}

resource "aws_instance" "app_server-2" {
  ami           = "ami-0c9c942bd7bf113a2"
  instance_type = "t2.micro"
  key_name = "${var.keyName}"
  subnet_id = aws_subnet.private-northeast-2c.id
  security_groups = [aws_security_group.yhjec2-SG.id]
  user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p ${var.server_port} &
                EOF
  tags = {"Name"="${var.instance-2-name}"}
}

# resource "aws_instance" "app_server-3" {
#   ami           = "ami-0c9c942bd7bf113a2"
#   instance_type = "t2.micro"
#   key_name = "${var.keyName}"
#   subnet_id = aws_subnet.private-northeast-2d.id
#   security_groups = [aws_security_group.yhjec2-SG.id]
#   user_data = <<-EOF
#                 #!/bin/bash
#                 echo "Hello, World" > index.html
#                 nohup busybox httpd -f -p ${var.server_port} &
#                 EOF
#   tags = {"Name"="${var.instance-3-name}"}
# }

