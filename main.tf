variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "vpc_security_group_ids" {}
variable "subnet_id" {}
variable "key_name" {}
variable "instance_name" {}

provider "aws" {
  region     = "ap-northeast-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

data "aws_ami" "recent_amazon_linux_2" { #AmazonLinux2の最新AMIを取得
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "test_instance" {
  ami                     = data.aws_ami.recent_amazon_linux_2.image_id # latest-AmazonLinux2
  instance_type           = "t2.micro"
  vpc_security_group_ids  = [var.vpc_security_group_ids]
  subnet_id               = var.subnet_id
  key_name                = var.key_name
  availability_zone       = "ap-northeast-1d"
  disable_api_termination = true

  root_block_device {
    volume_type = "standard"
    volume_size = "30"
  }

  tags = {
    Name = var.instance_name
  }
}

# EIP
resource "aws_eip" "test_instance" {
  instance = aws_instance.test_instance.id
  vpc      = true
}

#インスタンスのEIPを出力
output "instance_ip" {
  value = aws_eip.test_instance.public_ip
}
