variable "subnet_cidr_blocks" {
  description = "CIDR blocks for the subnets."
  type        = list(string)
  default     = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
}

resource "aws_subnet" "example" {
  for_each = toset(var.subnet_cidr_blocks)

  vpc_id = aws_vpc.main.id

  cidr_block        = each.value
  availability_zone = "us-east-1a"
}

output "all_subnets" {
  value = aws_subnet.example
}

output "all_ids" {
  value = values(aws_subnet.example)[*].id
}
