variable "keyName" {
  description = "keyName"
  type = map
  default = {}
}

variable "instance-name" {
  description = "instance name"
  type=string
  default = "yhjInstance"
}

variable "server_port" {
  description = "server port"
  type=string
  default = "80"
}

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
  default = "yhjVPC-subnet-private1-ap-north-2a"
}

variable "private-rtb-a-name" {
  description = "a private route table name"
  type=string
  default = "yhjVPC-rtb-private-ap-northeast-2a"
}

variable "private-subnet-c-name" {
  description = "c private subnet name"
  type=string
  default = "yhjVPC-subnet-private1-ap-north-2c"
}

variable "private-rtb-c-name" {
  description = "c private route table name"
  type=string
  default = "yhjVPC-rtb-private-ap-northeast-2c"
}

variable "private-subnet-d-name" {
  description = "d private subnet name"
  type=string
  default = "yhjVPC-subnet-private1-ap-north-2d"
}

variable "private-rtb-d-name" {
  description = "d private route table name"
  type=string
  default = "yhjVPC-rtb-private-ap-northeast-2d"
}

variable "public-subnet-a-name" {
  description = "a public subnet name"
  type=string
  default = "yhjVPC-subnet-public-ap-north-2a"
}

variable "public-subnet-c-name" {
  description = "b public subnet name"
  type=string
  default = "yhjVPC-subnet-public-ap-north-2c"
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

variable "vpc_security_group-name" {
  description = "public route table name"
  type=string
  default = "yhjVPC-SecuritiyGroup"
}
