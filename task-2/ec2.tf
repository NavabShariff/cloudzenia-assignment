provider "aws" {
    region = var.region
}



# resource "aws_key_pair" "pem_key" {
#   key_name   = "cloudzenia-key"
#   public_key = file("~/.ssh/id_rsa.pub")
# }


resource "aws_security_group" "ec2_sg" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] 
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] 
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] 
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}

resource "aws_instance" "ec2_instances" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  count = length(var.private_subnet_ids)
  subnet_id             =  var.private_subnet_ids[count.index]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  # key_name               = aws_key_pair.pem_key.key_name 
  key_name   = "navab-office"
  tags = {
    Name = var.ec2_instances_names[count.index]
  }
}

resource "aws_security_group" "jump_host_sg" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    from_port   = 443
    to_port     = 443
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

resource "aws_instance" "ec2_jump_host" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id             =  var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.jump_host_sg.id]
  # key_name               = aws_key_pair.pem_key.key_name 
  key_name = "navab-office"
  tags = {
    Name = "Jump Host"
  }
}

# tg

# Target Groups
resource "aws_lb_target_group" "instance1_tg" {
  name     = "instance1-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"

  health_check {
    path     =  "/"
    port     = "80"
    protocol = "HTTP"
    matcher  = "200"
  }
}

resource "aws_lb_target_group" "instance2_tg" {
  name     = "instance2_tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path     =  "/"
    port     = "80"
    protocol = "HTTP"
    matcher  = "200"
  }
}

