provider "aws" {
    region = var.region
    profile = var.profile
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name

  tags = {
    Name = var.cluster_name
  }
}
