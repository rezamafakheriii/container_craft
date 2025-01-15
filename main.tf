data "aws_caller_identity" "current" {}

# tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "repository" {
  name                 = var.repository_name
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "KMS"
  }
}

resource "aws_ecr_repository_policy" "repository_iam_policy" {
  repository = aws_ecr_repository.repository.name
  policy     = data.aws_iam_policy_document.ecr_repo_policy.json
}

resource "aws_ecr_registry_scanning_configuration" "scan_configuration" {
  scan_type = "BASIC"

  rule {
    scan_frequency = "SCAN_ON_PUSH"
    repository_filter {
      filter      = "*"
      filter_type = "WILDCARD"
    }
  }
}
