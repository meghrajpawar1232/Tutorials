variable "subnet_cidr_blocks" {
  description = "CIDR blocks for the subnets."
  type        = list(string)
  default     = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
}

# resource "aws_subnet" "example" {
#   for_each = toset(var.subnet_cidr_blocks)

#   vpc_id = aws_vpc.main.id

#   cidr_block        = each.value
#   availability_zone = "us-east-1a"
# }

# output "all_subnets" {
#   value = aws_subnet.example
# }

# output "all_ids" {
#   value = values(aws_subnet.example)[*].id
# }

# module "subnets" {
#   source   = "../../modules/subnet"
#   for_each = toset(var.subnet_cidr_blocks)

#   vpc_id            = aws_vpc.main.id
#   subnet_cidr_block = each.value
# }

# output "subnet_ids" {
#   value       = values(module.subnets)[*].subnet_id
#   description = "The IDs of the created subnets."
# }

variable "custom_ports" {
  description = "Custom ports to open on the security group."
  type        = map(any)

  default = {
    80   = ["0.0.0.0/0"]
    8081 = ["10.0.0.0/16"]
  }
}

# resource "aws_security_group" "web" {
#   name   = "allow-web-access"
#   vpc_id = aws_vpc.main.id

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   for (port in var.custom_ports) {
#     ingress {
#       from_port   = port.key
#       to_port     = port.key
#       protocol    = "tcp"
#       cidr_blocks = port.value
#     }
#   }
# }

resource "aws_security_group" "web" {
  name   = "allow-web-access"
  vpc_id = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.custom_ports

    content {
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = ingress.value
    }
  }
}
