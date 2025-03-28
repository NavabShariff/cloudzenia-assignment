terraform {
 backend "s3" {
  bucket = "cloudzenia-terraform-statefiles"
  key = "cloudzenia/rds/terraform.tfstate"
  region = "ap-south-1"
}
}