
resource "aws_vpc" "yhj-vpc" {
  cidr_block = "172.5.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {"Name" = "${var.vpc_name}"}

}

################################################################################
# Network ACL
################################################################################
resource "aws_default_network_acl" "aws_default_network_acl" {
  default_network_acl_id = aws_vpc.yhj-vpc.default_network_acl_id

  tags = {"Name" = "${var.net-acl-name}"}

  # inbound
  ingress {
    protocol = -1
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  # outbound
  egress {
    protocol = -1
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

}

################################################################################
# Internet Gateway
################################################################################
resource "aws_internet_gateway" "yhj-internet-gateway" {
  vpc_id = aws_vpc.yhj-vpc.id

  tags = {"Name" = "${var.internet-gtw-name}"}
}

################################################################################
# Private Subnets - ap-northeast-2a
################################################################################
resource "aws_subnet" "private-northeast-2a" {
  vpc_id = aws_vpc.yhj-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-2a"
  # availability_zone_id = "apne2-az1" 둘 중 하나만 지정 

  tags = {"Name" = "${var.private-subnet-a-name}"}

}

resource "aws_route_table" "private-northeast-2a" {
  vpc_id = aws_vpc.yhj-vpc.id
  tags = {"Name" = "${var.private-rtb-a-name}"}
}

resource "aws_route_table_association" "private-northeast-2a" {
  subnet_id = aws_subnet.private-northeast-2a.id
  route_table_id = aws_route_table.private-northeast-2a.id
}

################################################################################
# Private Subnets - ap-northeast-2b
################################################################################
resource "aws_subnet" "private-northeast-2b" {
  vpc_id = aws_vpc.yhj-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-northeast-2b"
  # availability_zone_id = "apne2-az1" 둘 중 하나만 지정 

  tags = {"Name" = "${var.private-subnet-b-name}"}

}

resource "aws_route_table" "private-northeast-2b" {
  vpc_id = aws_vpc.yhj-vpc.id
  tags = {"Name" = "${var.private-rtb-b-name}"}
}

resource "aws_route_table_association" "private-northeast-2b" {
  subnet_id = aws_subnet.private-northeast-2b.id
  route_table_id = aws_route_table.private-northeast-2b.id
}

################################################################################
# Public Subnets
################################################################################
resource "aws_subnet" "public-subnet-2a" {
  vpc_id = aws_vpc.yhj-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-northeast-2a"
  # availability_zone_id = "apne2-az1" 둘 중 하나만 지정 

  tags = {"Name" = "${var.public-subnet-a-name}"}

}

resource "aws_subnet" "public-subnet-2b" {
  vpc_id = aws_vpc.yhj-vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-northeast-2b"
  # availability_zone_id = "apne2-az1" 둘 중 하나만 지정 

  tags = {"Name" = "${var.public-subnet-2b-name}"}

}

# 라우팅 테이블 선언 
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.yhj-vpc.id
  tags = {"Name" = "${var.public-rtb-name}"}
}

# 라우팅 테이블에 맵핑 
resource "aws_route_table_association" "public-rtb-association-2a" {
  subnet_id = aws_subnet.public-subnet-2b.id
  route_table_id = aws_route_table.public-rtb.id
}

resource "aws_route_table_association" "public-rtb-association-2b" {
  subnet_id = aws_subnet.public-subnet-2a.id
  route_table_id = aws_route_table.public-rtb.id
}

# VPC 라우팅 테이블에 경로를 생성하기 위한 리소스 제공
resource "aws_route" "public_internet_gateway" {    
  route_table_id = aws_route_table.public-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.yhj-internet-gateway.id
  timeouts {
    create = "5m"
  }
}

################################################################################
# Web Hosting Security Group
################################################################################
resource "aws_security_group" "yhjVPC-SecurityGroup" {
  vpc_id = aws_vpc.yhj-vpc.id
  name = "${var.vpc_security_group-name}"
  description = "${var.vpc_security_group-name}"

  tags = {"Name"="${var.vpc_security_group-name}"}
}

# 인바운드 규칙 추가 
resource "aws_security_group_rule" "securityGroupInbound-http" {
  security_group_id = aws_security_group.yhjVPC-SecurityGroup.id
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "TCP"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "securityGroupInbound-ssh" {
  security_group_id = aws_security_group.yhjVPC-SecurityGroup.id
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "TCP"
  cidr_blocks = [var.myIP]
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
