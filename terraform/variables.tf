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
  default = "project_auth"
}


variable "bucket_name" {
  type = string
  default = "dynamic-web-app-state-lock"
}

variable "dynamodb_table" {
  type = string
  default = "terraform-state-lock"
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "bucket_key" {
  type = string
  default = "backend/dynamic-website.tfstate"
}