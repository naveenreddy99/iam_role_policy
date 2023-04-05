data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

/* Task Execution Role */
resource "aws_iam_role" "task_execution_role" {
  name = "task_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

/* Task  Role*/
resource "aws_iam_role" "task_role" {
  name = "task_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

/* Policy Attachment to Task Execution Role*/
resource "aws_iam_role_policy_attachment" "task-execution-role-policy-attach" {
  count      = length(var.task_execution_role_managed_policies)
  policy_arn = element(var.task_execution_role_managed_policies, count.index)
  role       = aws_iam_role.task_execution_role.name
}

/* Policy Attachment to Task  Role*/
resource "aws_iam_role_policy_attachment" "task-role-policy-attach" {
  #count      = length(var.policies)
  policy_arn = aws_iam_policy.asbteam_policy.arn
  role       = aws_iam_role.task_role.name
}

