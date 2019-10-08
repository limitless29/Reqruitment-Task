variable "access_key" {}
variable "secret_key" {}

variable "region" {
  default = "eu-west-1"
}

variable "vpc_cidr" {
  default = "10.9.0.0/16"
}
#variable "private_subnets" {
#  default = ["10.9.0.0/24", "10.9.1.0/24"]
#}
#variable "public_subnets" {
#  default = ["10.9.10.0/24", "10.9.11.0/24"]
#}
variable "database_subnets" {
  default = ["10.9.20.0/24", "10.9.21.0/24"]
}
#variable "sshpubkey_file" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_name" { default = "Oct9-VPC" }

variable "main_routing_table" { default = "Oct9-pub-route"}

variable "IGW_name" { default = "Oct9-igw"}

variable "key_name" { default = "" }

variable "pub_snet_cidr" { default = "10.9.10.0/24" }

variable "prv_snet_cidr" { default = "10.9.0.0/24" }

variable "pub_snet_name"  { default = "Oct9pubsnet" }
variable "prv_snet_name"  { default = "Oct9prvsnet" }
