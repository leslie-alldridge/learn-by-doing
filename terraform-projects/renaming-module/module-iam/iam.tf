# // PLEASE NOTE:
# // This code is commented out in my final commit but you
# // can uncomment it, after commenting out iam.tf (in the root directory)
# // so that the terraform example works

# // The idea is to have a before module state and then a post module refactor
# // state. I've copy pasted the code here to save you a bit of time :)

# data "aws_iam_policy_document" "instance_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role" "example_role" {
#   name                = "yak_role"
#   assume_role_policy  = data.aws_iam_policy_document.instance_policy.json
#   managed_policy_arns = [aws_iam_policy.policy_one.arn, aws_iam_policy.policy_two.arn]
# }

# resource "aws_iam_policy" "policy_one" {
#   name = "policy-618033"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action   = ["ec2:Describe*"]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }

# resource "aws_iam_policy" "policy_two" {
#   name = "policy-381966"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action   = ["s3:ListAllMyBuckets", "s3:ListBucket", "s3:HeadBucket"]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }
