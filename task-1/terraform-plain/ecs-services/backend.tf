terraform {
 backend "s3" {
  bucket = "cloudzenia-terraform-statefiles"
  key = "cloudzenia/ecs-services/terraform.tfstate"
  region = "ap-south-1"
}
}