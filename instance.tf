data "aws_ami" "ami" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]

  }
}

resource "random_id" "random_node" {
  byte_length = 2
  count       = var.main_instance_count
}

resource "aws_key_pair" "auth" {
  key_name = var.key_name
  public_key = file(var.public_key_path)
  
}

resource "aws_instance" "instance-public" {
  count         = var.main_instance_count
  instance_type = var.main_instance_type
  ami           = data.aws_ami.ami.id

  vpc_security_group_ids = [aws_security_group.zoey-public-sg.id]
  subnet_id              = aws_subnet.zoey_public_subnet[count.index].id

  user_data = templatefile("./main-userdata.tpl", { new_hostname = "zoey-instance-${random_id.random_node[count.index].dec}" })

  root_block_device {
    volume_size = var.main_vol_size
  }

  key_name = aws_key_pair.auth.id
  tags = {
    Name = "zoey-instance-${random_id.random_node[count.index].dec}"
  }

  provisioner "local-exec" {
    command = "printf '/n${self.public_ip}' >> aws_hosts"
  }
  provisioner"local-exec" {
    when = destroy
    command = "sed -i '/^[0-9]/d' aws_hosts"
  }
}

resource "null_resource" "grafana_update" {
  count = var.main_instance_count
  provisioner "remote-exec" {
    inline = ["sudo apt upgrade -y grafana && touch upgrade.log && echo 'I updated Grafana' >> upgrade.log"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.key_name)
      host        = aws_instance.instance-public[count.index].public_ip
    }
  }
}