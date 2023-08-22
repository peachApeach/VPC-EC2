
resource "aws_vpc" "yhj-vpc" {
  cidr_block = "172.5.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {"Name" = "${var.vpc-name}"}

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
  cidr_block = "172.5.128.0/20"
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
# Private Subnets - ap-northeast-2c
################################################################################
resource "aws_subnet" "private-northeast-2c" {
  vpc_id = aws_vpc.yhj-vpc.id
  cidr_block = "172.5.144.0/20"
  availability_zone = "ap-northeast-2c"
  # availability_zone_id = "apne2-az1" 둘 중 하나만 지정 

  tags = {"Name" = "${var.private-subnet-c-name}"}

}

resource "aws_route_table" "private-northeast-2c" {
  vpc_id = aws_vpc.yhj-vpc.id
  tags = {"Name" = "${var.private-rtb-c-name}"}
}

resource "aws_route_table_association" "private-northeast-2c" {
  subnet_id = aws_subnet.private-northeast-2c.id
  route_table_id = aws_route_table.private-northeast-2c.id
}

################################################################################
# Private Subnets - ap-northeast-2d
################################################################################
resource "aws_subnet" "private-northeast-2d" {
  vpc_id = aws_vpc.yhj-vpc.id
  cidr_block = "172.5.160.0/20"
  availability_zone = "ap-northeast-2d"
  # availability_zone_id = "apne2-az1" 둘 중 하나만 지정 

  tags = {"Name" = "${var.private-subnet-d-name}"}

}

resource "aws_route_table" "private-northeast-2d" {
  vpc_id = aws_vpc.yhj-vpc.id
  tags = {"Name" = "${var.private-rtb-d-name}"}
}

resource "aws_route_table_association" "private-northeast-2d" {
  subnet_id = aws_subnet.private-northeast-2d.id
  route_table_id = aws_route_table.private-northeast-2d.id
}

################################################################################
# Public Subnets
################################################################################
resource "aws_subnet" "public-subnet-2a" {
  vpc_id = aws_vpc.yhj-vpc.id
  cidr_block = "172.5.0.0/20"
  availability_zone = "ap-northeast-2a"
  # availability_zone_id = "apne2-az1" 둘 중 하나만 지정 

  tags = {"Name" = "${var.public-subnet-a-name}"}

}

resource "aws_subnet" "public-subnet-2c" {
  vpc_id = aws_vpc.yhj-vpc.id
  cidr_block = "172.5.16.0/20"
  availability_zone = "ap-northeast-2c"
  # availability_zone_id = "apne2-az1" 둘 중 하나만 지정 

  tags = {"Name" = "${var.public-subnet-c-name}"}

}

resource "aws_subnet" "public-subnet-2d" {
  vpc_id = aws_vpc.yhj-vpc.id
  cidr_block = "172.5.32.0/20"
  availability_zone = "ap-northeast-2d"
  # availability_zone_id = "apne2-az1" 둘 중 하나만 지정 

  tags = {"Name" = "${var.public-subnet-d-name}"}

}

# 라우팅 테이블 선언 
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.yhj-vpc.id
  tags = {"Name" = "${var.public-rtb-name}"}
}

# 라우팅 테이블에 맵핑 
resource "aws_route_table_association" "public-rtb-association-2a" {
  subnet_id = aws_subnet.public-subnet-2a.id
  route_table_id = aws_route_table.public-rtb.id
}

resource "aws_route_table_association" "public-rtb-association-2c" {
  subnet_id = aws_subnet.public-subnet-2c.id
  route_table_id = aws_route_table.public-rtb.id
}

resource "aws_route_table_association" "public-rtb-association-2d" {
  subnet_id = aws_subnet.public-subnet-2d.id
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
# Elastic IP
################################################################################
resource "aws_eip" "eip_nat_a" {
  vpc   = true

  lifecycle {
    create_before_destroy = true
  }

  tags = { Name="${var.eip-nat-a-name}"}
}

resource "aws_eip" "eip_nat_c" {
  vpc   = true

  lifecycle {
    create_before_destroy = true
  }

  tags = { Name="${var.eip-nat-c-name}"}
}

resource "aws_eip" "eip_nat_d" {
  vpc   = true

  lifecycle {
    create_before_destroy = true
  }
  
  tags = { Name="${var.eip-nat-d-name}"}
}

################################################################################
# NAT Gateway
################################################################################
resource "aws_nat_gateway" "public-nat-a" {
  allocation_id = aws_eip.eip_nat_a.id
  subnet_id = aws_subnet.private-northeast-2a.id
  tags = { Name = "${var.public-nat-a-name}"}
  depends_on = [ aws_internet_gateway.yhj-internet-gateway ]
}

resource "aws_nat_gateway" "public-nat-c" {
  allocation_id = aws_eip.eip_nat_c.id
  subnet_id = aws_subnet.private-northeast-2c.id
  tags = { Name = "${var.public-nat-c-name}"}
  depends_on = [ aws_internet_gateway.yhj-internet-gateway ]
}

resource "aws_nat_gateway" "public-nat-d" {
  allocation_id = aws_eip.eip_nat_d.id
  subnet_id = aws_subnet.private-northeast-2d.id
  tags = { Name = "${var.public-nat-d-name}"}
  depends_on = [ aws_internet_gateway.yhj-internet-gateway ]
}

################################################################################
# NAT Gateway 라우팅 테이블 맵핑
################################################################################
# vpc 라우팅 테이블에 항목을 생성하기 위한 리소스 
resource "aws_route" "private-nat-a" {
  route_table_id = aws_route_table.private-northeast-2a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.public-nat-a.id
}

resource "aws_route" "private-nat-c" {
  route_table_id = aws_route_table.private-northeast-2c.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.public-nat-c.id
}

resource "aws_route" "private-nat-d" {
  route_table_id = aws_route_table.private-northeast-2d.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.public-nat-d.id
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
  cidr_blocks = ["0.0.0.0/0"]
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
