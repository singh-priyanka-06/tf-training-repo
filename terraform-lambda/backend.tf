terraform {
  backend "s3" {
    bucket = "tf-training-bkt" # Update the s3 backend bucket here
    key = "terraform-backend/terraform-lambda/terraform.tfstate"
    region = "ap-south-1"
  }
}