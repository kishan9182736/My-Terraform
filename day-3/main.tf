# ---------------------------
# PROVIDER
# ---------------------------

provider "aws" {
  region = "eu-central-1"
}


# ---------------------------
# VARIABLES
# ---------------------------

variable "cidr" {
    default = "10.0.0.0/16"
}

# ---------------------------
# SSH KEY PAIR
# ---------------------------


resource "aws_key_pair" "example" {
  key_name = "kishan-ec2-key"
  public_key = file("/home/codespace/.ssh/id_rsa.pub")
}


# ---------------------------
# VPC
# ---------------------------

resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
  tags = { Name = "my-vpc" }
}


# ---------------------------
# SUBNET
# ---------------------------

resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "eu-central-1a"
  map_public_ip_on_launch = true 
  tags = { Name = "subnet-1" }
}


# ---------------------------
# INTERNET GATEWAY
# ---------------------------

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
  tags   = { Name = "igw" }
}


# ---------------------------
# ROUTE TABLE
# ---------------------------

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id

 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
 }
 
 tags = { Name = "rt-main" }

}

resource "aws_route_table_association" "rt1" {
  subnet_id = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}



# ---------------------------
# SECURITY GROUP
# ---------------------------

resource "aws_security_group" "websg" {

  name = "web"
  vpc_id = aws_vpc.myvpc.id
  
 
  ingress  {

    description = "HTTP from VPC"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress  {

    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 egress  {

    #Outbound: allow all
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

tags = { Name = "web-sg" }

}



# ---------------------------
# EC2 INSTANCE
# ---------------------------

resource "aws_instance" "server" {
  
  ami = "ami-02003f9f0fde924ea"
  instance_type = "t2.micro"
  key_name = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.websg.id]
  subnet_id = aws_subnet.sub1.id

  connection {

      type = "ssh"
      user = "ubuntu"
      private_key = file("/home/codespace/.ssh/id_rsa")
      host = self.public_ip
  } 


provisioner "remote-exec"{

  inline =[

      "sudo apt update -y && sudo apt install -y git python3-flask",
      "git clone https://github.com/kishan9182736/My-Terraform.git /home/ubuntu/My-Terraform",
      "python3 /home/ubuntu/My-Terraform/day-3/app.py &"
   
   ]
  
 }
  tags = { Name = "web-server" }
}




