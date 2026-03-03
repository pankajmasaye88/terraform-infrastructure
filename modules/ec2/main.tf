resource "aws_instance" "public_vm" {
  ami                    = "ami-02b8269d5e85954ef"
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.sg_id]

  tags = {
    Name = "alex-public-vm"
  }
}

resource "aws_instance" "private_vm" {
  ami                    = "ami-02b8269d5e85954ef"
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.sg_id]

  tags = {
    Name = "alex-private-vm"
  }
}
