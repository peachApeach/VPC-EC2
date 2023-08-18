################################################################################
# EC2 instance
################################################################################
resource "aws_instance" "app_server" {
  ami           = "ami-0c6e5afdd23291f73"
  instance_type = "t2.micro"
  key_name = "pandayh7DevOps"
  subnet_id = aws_subnet.public-subnet-2a.id
  associate_public_ip_address = true
  security_groups = [aws_security_group.tutorialVPC-SecurityGroup.id]
  user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p ${var.server_port} &
                EOF
  tags = {"Name"="tutorialInstance"}
}