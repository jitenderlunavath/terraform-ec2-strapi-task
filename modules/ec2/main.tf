resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "pem_key" {
  filename        = "strapi-key.pem"
  content         = tls_private_key.ssh_key.private_key_pem
  file_permission = "0400"
}

resource "aws_key_pair" "keypair" {
  key_name   = "strapi-key-${random_id.suffix.hex}"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_security_group" "strapi_sg" {
  name = "strapi-sg-${random_id.suffix.hex}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1337
    to_port     = 1337
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

resource "aws_instance" "strapi_ec2" {
  ami                    = "ami-0f5ee92e2d63afc18"
  instance_type          = "t3.small"
  key_name               = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  tags = {
    Name = "Strapi-Server"
  }
}
