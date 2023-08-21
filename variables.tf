variable "keyName" {
  description = "keyName"
  type = map
  default = {}
}

variable "instance-name" {
  description = "instance name"
  type="String"
  default = "yhjInstance"
}

variable "server_port" {
  description = "server port"
  type="String"
  default = "80"
}

variable "vpc-name" {
  description = "vpc name"
  type="String"
  default = "yhj-vpc"
}

variable "net-acl-name" {
    description = "network ACL Name"
    type="string"
    default = "yhjVPC-acl"
}

variable "internet-gtw-name" {
  description = "internet gateway name"
  type="String"
  default = "yhj-internet-gatway"
}

variable "private-subnet-a-name" {
  description = "a private subnet name"
  type="String"
  default = "yhjVPC-subnet-private1-ap-north-2a"
}

variable "private-rtb-a-name" {
  description = "a private route table name"
  type="String"
  default = "yhjVPC-rtb-private-ap-northeast-2a"
}

variable "private-subnet-b-name" {
  description = "b private subnet name"
  type="String"
  default = "yhjVPC-subnet-private1-ap-north-2b"
}

variable "private-rtb-b-name" {
  description = "b private route table name"
  type="String"
  default = "yhjVPC-rtb-private-ap-northeast-2b"
}

variable "private-subnet-d-name" {
  description = "d private subnet name"
  type="String"
  default = "yhjVPC-subnet-private1-ap-north-2d"
}

variable "private-rtb-d-name" {
  description = "d private route table name"
  type="String"
  default = "yhjVPC-rtb-private-ap-northeast-2d"
}

variable "public-subnet-a-name" {
  description = "a public subnet name"
  type="String"
  default = "yhjVPC-subnet-public-ap-north-2a"
}

variable "public-subnet-b-name" {
  description = "b public subnet name"
  type="String"
  default = "yhjVPC-subnet-public-ap-north-2b"
}

variable "public-rtb-name" {
  description = "public route table name"
  type="String"
  default = "yhjVPC-rtb-public"
}

variable "vpc_security_group-name" {
  description = "public route table name"
  type="String"
  default = "yhjVPC-SecuritiyGroup"
}
