provider "aws" {
  profile = "kong_poweruser-162225303348"
  region  = var.aws_region
}

resource "aws_instance" "ec2_instance" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              sudo su
              sudo yum update -y
              sudo yum install -y docker
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              sudo curl -L "https://github.com/docker/compose/releases/download/v2.21.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              sudo chmod +x /usr/local/bin/docker-compose
              if [ -f /usr/local/bin/docker-compose ]; then
                echo "docker-compose installed successfully"
              else
                echo "docker-compose installation failed" >&2
                exit 1
              fi
              EOF

  provisioner "file" {
    source      = var.compose_file_path
    destination = "/home/ec2-user/docker-compose.yml"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "file" {
    source      = var.cert_file_path
    destination = "/home/ec2-user/kong-cert.crt"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "file" {
    source      = var.key_file_path
    destination = "/home/ec2-user/kong-cert.key"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "file" {
    source      = var.prometheus_file_path
    destination = "/home/ec2-user/prometheus.yml"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "cd /home/ec2-user",
      "sudo /usr/local/bin/docker-compose up -d"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  tags = {
    Name = "konnect-hands-on"
  }
}
