variable "region" {
  default = "us-east-1"
}

variable "prefix" {
  default = "main"
}

variable "project" {
    default = "DevOps-with-AWS-Terrafrom-GitHubAction"
}

variable "contact" {  
}

variable "vpc_cidrblock" {
    default = "10.0.0.0/16"
}

variable "subnet_cidr" {
    type=list(string)
    default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}

variable "sshkey" {
    type = string
    description = "Private SSH key to access the server"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "db_name" {
  default = "secure-architecture"
}

variable "db_username" {
}