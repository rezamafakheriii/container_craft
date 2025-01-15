variable "repository_name" {
  description = "Name of the repo"
  type        = string
}

variable "iam_role" {
  type        = string
  description = "Self-hosted runner EC2 instance role"
}

variable "aws_account_id" {
  description = "Target AWS Account ID"
  type        = string
}

variable "organization_accounts" {
  description = "List of additional accounts in the organization that can pull from the ECR repository"
  type        = list(string)
  default     = ["585008041767"]
}
