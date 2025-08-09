provider "aws" {
  region = "eu-central-1"
}
module "ec2-instance" {
  source = "./modules/ec2_instances"
  ami_value = "ami-02003f9f0fde924ea"
  instance_type_value = "t2.micro"
}
