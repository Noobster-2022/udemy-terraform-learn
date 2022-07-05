provider "aws" {
  region = "us-east-1"
}   

resource "aws_vpc" "udemy-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {Name: "MyVPC"}
  
}

variable "subnet_cidr_block" {
  description = "cidr block" 
}

resource "aws_subnet" "udemy-subnet-1" {
  vpc_id = aws_vpc.udemy-vpc.id
  cidr_block = var.subnet_cidr_block [0]
  availability_zone = "us-east-1a"
  tags = {
    Name: "subnet-1"
  }
}
data "aws_vpc" "existing_vpc" {
  default = true
}

resource "aws_subnet" "udemy-subnet-2" {
  vpc_id = data.aws_vpc.existing_vpc.id
  cidr_block = var.subnet_cidr_block [1]
  availability_zone = "us-east-1a"
  tags = {
    Name: "subnet-2"
  }
}

output "dev-subnet-1" {
  value = aws_subnet.udemy-subnet-1.id
}

output "dev-subnet-2" {
  value = aws_subnet.udemy-subnet-2.id
}