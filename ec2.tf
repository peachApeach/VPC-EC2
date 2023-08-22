################################################################################
# EC2 instance
################################################################################
resource "aws_instance" "app_server-1" {
  ami           = "ami-0c9c942bd7bf113a2"
  instance_type = "t2.micro"
  key_name = "${var.keyName}"
  subnet_id = aws_subnet.private-northeast-2a.id
  security_groups = [aws_security_group.yhjVPC-SecurityGroup.id]
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
  security_groups = [aws_security_group.yhjVPC-SecurityGroup.id]
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
#   security_groups = [aws_security_group.yhjVPC-SecurityGroup.id]
#   user_data = <<-EOF
#                 #!/bin/bash
#                 echo "Hello, World" > index.html
#                 nohup busybox httpd -f -p ${var.server_port} &
#                 EOF
#   tags = {"Name"="${var.instance-3-name}"}
# }