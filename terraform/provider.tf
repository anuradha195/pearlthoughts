provider "aws" {

  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

data "aws_ecr_repository" "ecr_repo" {
  name = "pearlthoughts"
}

data "aws_ecs_task_definition" "ecs_task_definition" {
  task_definition = "my-ecs-task"
}
