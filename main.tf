terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.42.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# AMI fetch
data "aws_ami" "os" {
  most_recent = true
  owners      = [var.ami_owner]

  filter {
    name   = "name"
    values = [var.ami_name_pattern]
  }
}

# Security Group
resource "aws_security_group" "sg" {
  name = "basic-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allowed_cidr]
  }
}

# EC2
resource "aws_instance" "server" {
  ami                    = data.aws_ami.os.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = var.instance_name
  }
}

# Elastic IP
resource "aws_eip" "eip" {
  instance = aws_instance.server.id
}