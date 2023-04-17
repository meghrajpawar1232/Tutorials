resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main"
  }
}
















































# resource "aws_iam_user" "example" {
#   name = "gilfoyle"
# }


# for (i = 0; i < 3; i++) {
#   resource "aws_iam_user" "example" {
#     name = "gilfoyle"
#   }
# }


# resource "aws_iam_user" "example" {
#   count = 3
#   name  = "gilfoyle"
# }


# for (i = 0; i < 3; i++) {
#   resource "aws_iam_user" "example" {
#     name = "gilfoyle.${i}"
#   }
# }

# resource "aws_iam_user" "example" {
#   count = 3
#   name  = "gilfoyle.${count.index}"
# }

# variable "user_names" {
#   description = "Create IAM users with these names"
#   type        = list(string)
#   default     = ["gilfoyle", "richard", "jared"]
# }


# for (i = 0; i < 3; i++) {
#   resource "aws_iam_user" "example" {
#     name = vars.user_names[i]
#   }
# }


# resource "aws_iam_user" "example" {
#   count = length(var.user_names)
#   name  = var.user_names[count.index]
# }

# output "first_arn" {
#   value       = aws_iam_user.example[0].arn
#   description = "The ARN for the first user"
# }

# output "all_arns" {
#   value       = aws_iam_user.example[*].arn
#   description = "The ARNs for all users"
# }

# module "users" {
#   source = "../../modules/iam-user"

#   count     = length(var.user_names)
#   user_name = var.user_names[count.index]
# }

# output "user_arns" {
#   value       = module.users[*].user_arn
#   description = "The ARNs of the created IAM users"
# }
