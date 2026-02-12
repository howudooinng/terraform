#spot - bidding hogi and then it is empty and it will be alocated
#on-demand - then what is the cost then it will be given

#ceating key pair (login)

resource "aws_key_pair" "my_key_new" {
  key_name   = "terra-key-ec2_new"
  public_key = file("terra-key-ec2.pub")
}

#Creating VPC & Security group
#default vpc also can be used

resource "aws_default_vpc" "default" {

}
resource "aws_security_group" "my_security_group" {
  name        = "automated-sg"
  description = "till will add a TF generated security group"
  vpc_id      = aws_default_vpc.default.id #interpolation(inherent or extract the value from a terrafrom block)

  #inbound rule = ingress
  #outbound rule = egress
  #cidr block = source range of IP addresses

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH open"
  }
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Flask App"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "automated-sg"
  }
}
#instance creation
#count = 3 #meta argument
resource "aws_instance" "my-instance" {
  for_each = tomap({
    micro-instance1 = "t3.micro",
    small-instance1 = "t3.small"
    micro-instance2 = "t3.micro",
    small-instance2 = "t3.small"
  })
  key_name        = aws_key_pair.my_key_new.key_name
  security_groups = [aws_security_group.my_security_group.name]
  instance_type   = each.value
  ami             = var.ec2_ami_id #ubuntu #amazonmachineimage
  user_data       = file("install_nginx.sh")
  root_block_device {
    #volume_size = var.ec2_root_storage_size
    volume_size = var.env == "prd" ? 20 : var.ec2_default_root_storage_size
    volume_type = "gp3"
  }
  tags = {
    Name = each.key
  }

}