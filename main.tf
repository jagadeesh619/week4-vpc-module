# Define a VPC resource
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}

# Define an Internet Gateway resource
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name
  }
}

# Define a public subnet resource
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = var.public_subnet_availability_zone

  tags = {
    Name = var.public_subnet_name
  }
}

# Define a private subnet resource
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = var.private_subnet_availability_zone

  tags = {
    Name = var.private_subnet_name
  }
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id

  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.allow_ssh_https.id]

  tags = {
    Name = var.instance_name
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public_rt_name
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.private_rt_name
  }
}


resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "allow_ssh_https" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = var.sg_name
  }
}

resource "aws_security_group_rule" "allow_https" {
  type        = "ingress"
  security_group_id = aws_security_group.allow_ssh_https.id
  from_port    = 80
  to_port      = 80
  protocol     = "tcp"
  cidr_blocks  = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_ssh" {
  type        = "ingress"
  security_group_id = aws_security_group.allow_ssh_https.id
  from_port    = 22
  to_port      = 22
  protocol     = "tcp"
  cidr_blocks  = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_traffic_ipv4" {
  type              = "egress"
  security_group_id = aws_security_group.allow_ssh_https.id
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "-1" # Semantically equivalent to all protocols
}



