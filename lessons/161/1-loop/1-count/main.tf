provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example" {
  vpc_id = aws_vpc.main.id

  cidr_block        = "10.0.0.0/19"
  availability_zone = "us-east-1a"
}
