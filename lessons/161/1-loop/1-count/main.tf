resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# resource "aws_subnet" "example" {
#   vpc_id = aws_vpc.main.id

#   cidr_block        = "10.0.0.0/19"
#   availability_zone = "us-east-1a"
# }

# for (i = 0; i < 3; i++) {
#   resource "aws_subnet" "example" {
#     vpc_id = aws_vpc.main.id

#     cidr_block        = "10.0.0.0/19"
#     availability_zone = "us-east-1a"
#   }
# }

# resource "aws_subnet" "example" {
#   count = 3

#   vpc_id = aws_vpc.main.id

#   cidr_block        = "10.0.0.0/19"
#   availability_zone = "us-east-1a"
# }

# for (i = 0; i < 3; i++) {
#   resource "aws_subnet" "example" {
#     vpc_id = aws_vpc.main.id

#     cidr_block        = "10.0.${i}.0/19"
#     availability_zone = "us-east-1a"
#   }
# }

# resource "aws_subnet" "example" {
#   count = 3

#   vpc_id = aws_vpc.main.id

#   cidr_block        = "10.0.${count.index}.0/19"
#   availability_zone = "us-east-1a"
# }

variable "subnet_cidr_blocks" {
  description = "CIDR blocks for the subnets."
  type        = list(string)
  default     = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
}

# for (i = 0; i < 3; i++) {
#   resource "aws_subnet" "example" {
#     vpc_id = aws_vpc.main.id

#     cidr_block        = vars.subnet_cidr_blocks[i]
#     availability_zone = "us-east-1a"
#   }
# }

# resource "aws_subnet" "example" {
#   count = length(var.subnet_cidr_blocks)

#   vpc_id = aws_vpc.main.id

#   cidr_block        = var.subnet_cidr_blocks[count.index]
#   availability_zone = "us-east-1a"
# }

# output "first_id" {
#   value       = aws_subnet.example[0].id
#   description = "The ID for the first subnet."
# }

# output "all_ids" {
#   value       = aws_subnet.example[*].id
#   description = "The IDs for all subnets."
# }

module "subnets" {
  source = "../../modules/subnet"

  vpc_id = aws_vpc.main.id

  count             = length(var.subnet_cidr_blocks)
  subnet_cidr_block = var.subnet_cidr_blocks[count.index]
}

output "all_ids" {
  value       = module.subnets[*].subnet_id
  description = "The IDs for all subnets."
}
