provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "kishan" {

  ami = "ami-02003f9f0fde924ea"
  instance_type = "t2.micro"

}

  resource "aws_s3_bucket" "name_s3_bucket" {
  bucket = "kishan-s3-demo-xyz"
}
resource "aws_dynamodb_table" "terraform_lock" {
  name = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
