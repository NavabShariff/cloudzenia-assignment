terraform {
 backend "s3" {
  bucket = "cloudzenia-terraform-statefiles"
  key = "cloudzenia/vpc-network/terraform.tfstate"
  region = "ap-south-1"
}
}