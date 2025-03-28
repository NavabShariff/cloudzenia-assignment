terraform {
 backend "s3" {
  bucket = "cloudzenia-terraform-statefiles"
  key = "cloudzenia/task-2/infra/terraform.tfstate"
  region = "ap-south-1"
}
}