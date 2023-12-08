variable "vpc_cidr" {
  type    = string
  default = "10.123.0.0/16"
}

variable "public_cidrs" {
  type    = list(string)
  default = ["10.123.1.0/24", "10.123.3.0/24"]
}

variable "private_cidrs" {
  type    = list(string)
  default = ["10.123.5.0/24", "10.123.7.0/24"]
}

variable "access_ip" {
  type    = string
  default = "0.0.0.0/0"
}

variable "public_key"{}

variable "private_key" {}

variable "key_name" {
  type = string 
}


variable "bucket_name" {
  type = string
}

variable "dynamodb_table" {
  type = string
}

variable "region" {
  type = string
}

variable "bucket_key" {
  type = string
}