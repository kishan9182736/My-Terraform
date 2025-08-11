terraform {
  backend "s3" {
 
    bucket = "kishan-s3-demo-xyz"
    region = "eu-central-1"
    key    = "kishan/terraform.tfstate"
    dynamodb_table = "terraform_lock"
  }

 
}
