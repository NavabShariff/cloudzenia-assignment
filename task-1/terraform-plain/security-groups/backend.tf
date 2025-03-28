terraform {
 backend "s3" {
  bucket = "cloudzenia-terraform-statefiles"
  key = "cloudzenia/security-groups/terraform.tfstate"
  region = "ap-south-1"
}
}