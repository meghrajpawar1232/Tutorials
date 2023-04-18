Terraform tips & tricks: loops, if-statements, and gotchas

https://blog.gruntwork.io/terraform-tips-tricks-loops-if-statements-and-gotchas-f739bbae55f9

## Loops

create tutorial/steps
record steps

- create `1-loop/1-count`
- create `provider.tf`
```tf
provider "aws" {
  region = "us-east-1"
}
```
- create `main.tf`
```tf
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
```
- terraform init
- terraform apply
- add subnet
```tf
resource "aws_subnet" "example" {
  vpc_id = aws_vpc.main.id

  cidr_block        = "10.0.0.0/19"
  availability_zone = "us-east-1a"
}
```

- terraform plan
- update subnet
```tf
for (i = 0; i < 3; i++) {
  resource "aws_subnet" "example" {
    vpc_id = aws_vpc.main.id

    cidr_block        = "10.0.0.0/19"
    availability_zone = "us-east-1a"
  }
}
```

- update subnet
```
resource "aws_subnet" "example" {
  count = 3

  vpc_id = aws_vpc.main.id

  cidr_block        = "10.0.0.0/19"
  availability_zone = "us-east-1a"
}
```

- terraform plan

- update subnet
```
for (i = 0; i < 3; i++) {
  resource "aws_subnet" "example" {
    vpc_id = aws_vpc.main.id

    cidr_block        = "10.0.${i}.0/19"
    availability_zone = "us-east-1a"
  }
}
```

- update subnet
```
resource "aws_subnet" "example" {
  count = 3

  vpc_id = aws_vpc.main.id

  cidr_block        = "10.0.${count.index}.0/19"
  availability_zone = "us-east-1a"
}
```

- terraform plan

- update subnet
```
variable "subnet_cidr_blocks" {
  description = "CIDR blocks for the subnets."
  type        = list(string)
  default     = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
}

for (i = 0; i < 3; i++) {
  resource "aws_subnet" "example" {
    vpc_id = aws_vpc.main.id

    cidr_block        = vars.subnet_cidr_blocks[i]
    availability_zone = "us-east-1a"
  }
}
```

- update subnet
```
resource "aws_subnet" "example" {
  count = length(var.subnet_cidr_blocks)

  vpc_id = aws_vpc.main.id

  cidr_block        = var.subnet_cidr_blocks[count.index]
  availability_zone = "us-east-1a"
}
```

- terraform plan

- update subnet
```
output "first_id" {
  value       = aws_subnet.example[0].id
  description = "The ID for the first subnet."
}
```

- terraform plan
- terraform apply

- replace first subnet
```
output "all_ids" {
  value       = aws_subnet.example[*].id
  description = "The IDs for all subnets."
}
```

- terraform apply

- remove subnet
- terraform apply

- create `modules/subnet`
- create `main.tf`
```
resource "aws_subnet" "example" {
  vpc_id = var.vpc_id

  cidr_block        = var.subnet_cidr_block
  availability_zone = "us-east-1a"
}
```
- create `output.tf`
```
output "subnet_id" {
  value       = aws_subnet.example.id
  description = "The ID for the first subnet."
}
```
- create `variables.tf`
```
variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet."
  type        = string
}
```

- update subnet
```
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
```

- terraform init
- terraform apply
- remove second item
- terraform apply