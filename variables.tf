variable "keyName" {
  description = "keyName"
  type = string
}

variable "instance-1-name" {
  description = "instance name"
  type=string
  default = "yhjInstance-1"
}

variable "instance-2-name" {
  description = "instance name"
  type=string
  default = "yhjInstance-2"
}

variable "instance-3-name" {
  description = "instance name"
  type=string
  default = "yhjInstance-3"
}

variable "server_port" {
  description = "server port"
  type=string
  default = "80"
}

# ec2 security group
variable "ec2-sg-name" {
  type = string
  default = "yhjEc2-sg"
}

# vpc
variable "vpc-name" {
  description = "vpc name"
  type=string
  default = "yhj-vpc"
}

variable "net-acl-name" {
    description = "network ACL Name"
    type=string
    default = "yhjVPC-acl"
}

variable "internet-gtw-name" {
  description = "internet gateway name"
  type=string
  default = "yhj-internet-gatway"
}

variable "private-subnet-a-name" {
  description = "a private subnet name"
  type=string
  default = "yhjVPC-subnet-private1-ap-northeast-2a"
}

variable "private-rtb-a-name" {
  description = "a private route table name"
  type=string
  default = "yhjVPC-rtb-private-ap-northeast-2a"
}

variable "private-subnet-c-name" {
  description = "c private subnet name"
  type=string
  default = "yhjVPC-subnet-private1-ap-northeast-2c"
}

variable "private-rtb-c-name" {
  description = "c private route table name"
  type=string
  default = "yhjVPC-rtb-private-ap-northeast-2c"
}

variable "private-subnet-d-name" {
  description = "d private subnet name"
  type=string
  default = "yhjVPC-subnet-private1-ap-northeast-2d"
}

variable "private-rtb-d-name" {
  description = "d private route table name"
  type=string
  default = "yhjVPC-rtb-private-ap-northeast-2d"
}

variable "public-subnet-a-name" {
  description = "a public subnet name"
  type=string
  default = "yhjVPC-subnet-public-ap-northeast-2a"
}

variable "public-subnet-c-name" {
  description = "b public subnet name"
  type=string
  default = "yhjVPC-subnet-public-ap-northeast-2c"
}

variable "public-subnet-d-name" {
  description = "d public subnet name"
  type=string
  default = "yhjVPC-subnet-public-ap-north-2d"
}

variable "public-rtb-name" {
  description = "public route table name"
  type=string
  default = "yhjVPC-rtb-public"
}

#eip
variable "eip-nat-a-name" {
  type = string
  default = "yhjeip-nat-a-name"
}

variable "eip-nat-c-name" {
  type = string
  default = "yhjeip-nat-c-name"
}

variable "eip-nat-d-name" {
  type = string
  default = "yhjeip-nat-d-name"
}

# nat gateway
variable "public-nat-a-name" {
  type = string
  default = "yhjNAT-public-a"
}

variable "public-nat-c-name" {
  type = string
  default = "yhjNAT-public-c"
}

variable "public-nat-d-name" {
  type = string
  default = "yhjNAT-public-d"
}

# security group
variable "vpc_security_group-name" {
  description = "public route table name"
  type=string
  default = "yhjVPC-SecuritiyGroup"
}

# alb
variable "alb-sg-name" {
  type = string
  default = "yhjalb-sg"
}

variable "public-alb-name" {
  type = string
  default = "yhjalb"
}

variable "alb-tg-name" {
  type = string
  default = "yhjAlb-tg"
}