provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "example" {
  key_name   = var.keypair_name
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_key_pair" "example" {
  key_name = aws_key_pair.example.key_name

  depends_on = [aws_key_pair.example]
}

resource "null_resource" "download_key" {
  provisioner "local-exec" {
    command = "cp ${data.aws_key_pair.example.key_material} ~/Downloads/${var.keypair_name}.pem"
  }

  depends_on = [data.aws_key_pair.example]
}


resource "aws_instance" "example" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.example.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.example.id]
  user_data              = var.user_data

  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "example" {
  name        = var.security_group_name
  description = "Security group for EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
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
