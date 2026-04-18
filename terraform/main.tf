data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}


resource "aws_security_group" "devsecops_sg" {
  name = "devsecops-sg"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App Ports"
    from_port   = 4000
    to_port     = 4005
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "devsecops_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  key_name        = var.key_name
  security_groups = [aws_security_group.devsecops_sg.name]

  tags = {
    Name = "devsecops-ec2"
  }
}