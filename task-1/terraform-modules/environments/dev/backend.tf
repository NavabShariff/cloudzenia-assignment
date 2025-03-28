terraform {
  backend "s3" {
    bucket = "cloudzenia-terraform-statefiles"
    key    = "cloudzenia-modules/terraform.tfstate"
    region = "ap-south-1"
  }
}
