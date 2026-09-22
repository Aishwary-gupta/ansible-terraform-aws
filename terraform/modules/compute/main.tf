# SSH Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = "${var.project_name}-${var.environment}-key"
  public_key = file(var.ssh_public_key_path)

  tags = {
    Name = "${var.project_name}-${var.environment}-key"
  }
}

# Dynamic Ubuntu 24.04 LTS AMI Lookup
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Web Server EC2 Instances (Multi-AZ)
resource "aws_instance" "web" {
  count                       = var.web_instance_count
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.deployer.key_name
  iam_instance_profile        = var.instance_profile_name
  vpc_security_group_ids      = [var.web_security_group_id]
  subnet_id                   = var.web_subnet_ids[count.index % length(var.web_subnet_ids)]
  associate_public_ip_address = var.associate_public_ip_address_web

  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-web-${count.index + 1}"
    Role        = "web"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Attach Web EC2 instances to ALB Target Group
resource "aws_lb_target_group_attachment" "web" {
  count            = var.web_instance_count
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.web[count.index].id
  port             = 80
}

# Redis Server EC2 Instance
resource "aws_instance" "redis" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  iam_instance_profile   = var.instance_profile_name
  vpc_security_group_ids = [var.redis_security_group_id]
  subnet_id              = var.redis_subnet_id

  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-redis"
    Role        = "redis"
    Environment = var.environment
    Project     = var.project_name
  }
}