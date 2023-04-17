provider "aws" {
  region = "us-east-1"
}


# resource "aws_iam_user" "anton" {
#   name = "anton"
# }


# for (i = 0; i < 3; i++) {
#   resource "aws_iam_user" "anton" {
#     name = "anton"
#   }
# }


# resource "aws_iam_user" "anton" {
#   count = 3
#   name  = "anton"
# }


# for (i = 0; i < 3; i++) {
#   resource "aws_iam_user" "example" {
#     name = "neo.${i}"
#   }
# }

# resource "aws_iam_user" "anton" {
#   count = 3
#   name  = "anton.${count.index}"
# }

variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}


# for (i = 0; i < 3; i++) {
#   resource "aws_iam_user" "example" {
#     name = vars.user_names[i]
#   }
# }


resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

output "first_arn" {
  value       = aws_iam_user.example[0].arn
  description = "The ARN for the first user"
}

output "all_arns" {
  value       = aws_iam_user.example[*].arn
  description = "The ARNs for all users"
}

