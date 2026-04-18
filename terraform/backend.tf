terraform {
  backend "s3" {
    bucket         = "devsecops-tf-state-parth123"
    key            = "devsecops-project/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "devsecops-lock"
  }
}