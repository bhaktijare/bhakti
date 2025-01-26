provider "aws" {
  region = "us-east-1"  # Set your desired AWS region
}
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2_security_group"
  description = "Allow SSH and HTTP"
  vpc_id      = "vpc-0a0977b4ca0560651"  # Replace with your VPC ID

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (update based on your needs)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP traffic from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }
}

resource "aws_instance" "instance1" {
  ami           = "ami-064519b8c76274859"  # Replace with your AMI ID
  instance_type = "t2.micro"
  security_groups= [aws_security_group.ec2_security_group.id]  # Reference the created SG
  subnet_id     = "subnet-054d8e27b7a066345"  # Replace with your Subnet ID
  key_name      = "pubkey"  # Replace with your Key Pair Name
}

resource "aws_instance" "instance2" {
  ami           = "ami-064519b8c76274859"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.ec2_security_group.id]  # Reference the created SG
  subnet_id     = "subnet-054d8e27b7a066345"
  key_name      = "pubkey"
}
