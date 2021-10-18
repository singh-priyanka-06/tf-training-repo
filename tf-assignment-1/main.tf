resource "aws_instance" "demo_ec2" {
  depends_on           = [aws_iam_role.ec2_role]
  ami                  = data.aws_ami.latest_ec2_linux.id
  instance_type        = var.ec2_instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "terraform-demo"
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role" "ec2_role" {
  name                = "ec2_depends-demo-role"
  managed_policy_arns = [aws_iam_policy.policy_one.arn]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    tag-key = "tag-value"
  }
  inline_policy {
    name = "my_inline_policy"

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

data "aws_ami" "latest_ec2_linux" {
  name_regex  = "amzn2-ami-hvm*"
  most_recent = true
  owners      = ["amazon"]
}

data "aws_instance" "ec2_instance_id" {

  filter {
    name   = "tag:Name"
    values = ["terraform-demo"]
  }
  depends_on = [aws_instance.demo_ec2]

}
