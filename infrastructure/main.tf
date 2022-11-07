# Provider aws

provider "aws" {
  region = "eu-west-1"
}


# creating my vpc
# cidr block is like a postcode,
# cidr 10.0.0.0/16 refers to the number of IPv4 addresses allocated 
# the CIDR number can be found in the variable.tf file 
# default tennacy instead of a dedicated one 
# A dedicated tenancy woudl ensure all EC2 instances are run on hardware soley for one person
resource "aws_vpc" "latif_test_vpc" {
    cidr_block = var.cidr_block
    instance_tenancy = "default"

    tags = {
        Name = "latif_test_vpc"
    }
}


# creating public subent within my vpc 
# vpc id will be obtained once vpc is created
# cidr block and az have been allocated
resource "aws_subnet" "latif_test_public_subnet_tf_1" {
vpc_id     = aws_vpc.latif_test_vpc.id
cidr_block = "10.0.1.0/24"
map_public_ip_on_launch = true
availability_zone = var.avail_zone

tags = {
 Name = "latif_test_public_subnet_tf_1"
 }
}
 

# second public subnet
resource "aws_subnet" "latif_test_public_subnet_tf_2" {
vpc_id     = aws_vpc.latif_test_vpc.id
cidr_block = "10.0.2.0/24"
map_public_ip_on_launch = true
availability_zone = "eu-west-1b"

tags = {
 Name = "latif_test_public_sebnet_tf_2"
 }
}


# thrid public subnet
resource "aws_subnet" "latif_test_public_subnet_tf_3" {
vpc_id     = aws_vpc.latif_test_vpc.id
cidr_block = "10.0.3.0/24"
map_public_ip_on_launch = true
availability_zone = "eu-west-1b"

tags = {
 Name = "latif_test_public_sebnet_tf_3"
 }
}



/* resource "aws_security_group" "test_app_tf" {
  name        = "test_app_tf"
  description = "Allow inbound traffic"
  vpc_id = aws_vpc.latif_test_vpc.id
  
  ingress {
    description      = "access to the app"
    from_port        = "80"
    to_port          = "80"
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  # ssh access
  ingress {
    description      = "ssh access"
    from_port        = "22"
    to_port          = "22"
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }
 # Allow port 3000 from anywhere
 # will leave in for now, will change depending on the app 
  ingress {
    from_port        = "3000"
    to_port          = "3000"
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

    }

egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" 
    cidr_blocks      = ["0.0.0.0/0"]
  }

      tags = {
        Name = "latif_tf_sg_app"
    }
} */



resource "aws_instance" "app_server" {
  ami           = "ami-096800910c1b781ba"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
} 


#Will use once app is complate
/* # # name of the resource
resource "aws_instance" "latif_tf_app" {
# security group
vpc_security_group_ids = ["${aws_security_group.latif_sg_app.id}"]
  subnet_id = "${aws_subnet.eng103a_latif_tf_vpc_public.id}"
  ami = "ami-0765af24323e4f33c"
  instance_type = var.instance_type
  associate_public_ip_address = true
  tags = {
    Name = var.app_instance_name 
  }
  key_name = var.key_pair_name
} */