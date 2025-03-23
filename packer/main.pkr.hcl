packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "ssh_username" {
  type    = string
  default = "ec2-user"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

source "amazon-ebs" "amazon-linux" {
  ami_name      = "custom-amazon-linux-docker-{{timestamp}}"
  instance_type = "${var.instance_type}"
  region        = "${var.aws_region}"
  source_ami_filter {
    filters = {
      name                = "al2023-ami-2023.*-kernel-6.1-x86_64"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "${var.ssh_username}"

  tags = {
    Name = "Custom Amazon Linux with Docker"
  }
}

build {
  name = "custom-amazon-linux"
  sources = [
    "source.amazon-ebs.amazon-linux"
  ]

  provisioner "shell" {
    script = "scripts/setup.sh"
  }

  provisioner "file" {
    source      = "packer_files/packer_key.pub"
    destination = "/tmp/packer_key.pub"
  }

  provisioner "shell" {
    inline = [
      "mkdir -p /home/${var.ssh_username}/.ssh",
      "cat /tmp/packer_key.pub > /home/${var.ssh_username}/.ssh/authorized_keys",
      "chmod 700 /home/${var.ssh_username}/.ssh",
      "chmod 600 /home/${var.ssh_username}/.ssh/authorized_keys",
      "chown -R ${var.ssh_username}:${var.ssh_username} /home/${var.ssh_username}/.ssh"
    ]
  }
} 