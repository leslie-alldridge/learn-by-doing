data "aws_iam_policy_document" "instance_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "example_role" {
  name                = "yak_role"
  assume_role_policy  = data.aws_iam_policy_document.instance_policy.json
  managed_policy_arns = [aws_iam_policy.policy_one.arn, aws_iam_policy.policy_two.arn]
}

resource "aws_iam_policy" "policy_one" {
  name = "policy-618033"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:Describe*"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "policy_two" {
  name = "policy-381966"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:ListAllMyBuckets", "s3:ListBucket", "s3:HeadBucket"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

// Note: To do the move you need to:
// 1. Copy paste every resource above this comment to module-iam/iam.tf
// 2. comment out all of the resources in this file
// 3. Uncomment the moved statement below
// 4. terraform plan & apply
// 5. Delete this entire file
// 6. Terraform plan & apply will show no changes - Done!

# moved {
#   from = aws_iam_policy.policy_one
#   to   = module.iam.aws_iam_policy.policy_one
# }


# moved {
#   from = aws_iam_policy.policy_two
#   to   = module.iam.aws_iam_policy.policy_two
# }


# moved {
#   from = aws_iam_role.example_role
#   to   = module.iam.aws_iam_role.example_role
# }
