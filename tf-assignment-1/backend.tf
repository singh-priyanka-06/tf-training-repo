terraform {
  backend "s3" {
    bucket = "tf-training-bkt" # update your s3 bucket here
    key = "terraform/tf-assignment-1/terraform.tfstate"
    region = "ap-south-1"
  }
}