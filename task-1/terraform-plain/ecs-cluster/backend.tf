terraform {
 backend "s3" {
  bucket = "cloudzenia-terraform-statefiles"
  key = "cloudzenia/ecs-cluster/terraform.tfstate"
  region = "ap-south-1"
}
}