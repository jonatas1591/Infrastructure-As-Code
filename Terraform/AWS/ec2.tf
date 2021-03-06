data "aws_ami" "amazonami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20210617.0-x86_64-gp2"]
  }

  owners = ["137112412989"]
}

resource "aws_key_pair" "kp_iac_ec2" {
  key_name   = "kp_iac_ec2"
  public_key = "keys/kp_pubkey_iac_ec2"
}


resource "aws_instance" "server" {
  depends_on = [
    aws_key_pair.kp_iac_ec2,
    aws_vpc.vpc_iac
  ]
  
  count                  = var.instance_count
  ami                    = data.aws_ami.amazonami.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.sub_iac_publ[count.index % length(aws_subnet.sub_iac_publ)].id
  vpc_security_group_ids = [aws_security_group.sg_vpc_iac_web_server.id]
  key_name               = "kp_iac_ec2"

  credit_specification {
    cpu_credits = "standard"
  }

  tags = {
    Name        = "${var.base_name["server_web"]}_${count.index + 1}"
    Environment = var.env["producao"]
    Backup      = "false"
    Provisioner = "IAC - Terraform"
  }
}


resource "null_resource" "sync_server" {

  depends_on = [aws_instance.server]

  count = var.instance_count

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = aws_instance.server[count.index].public_ip
    private_key = file("keys/kp_privkey_iac_ec2.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install ruby -y",
      "#sudo yum install php -y",
      "sudo yum install httpd -y",
      "sudo touch /var/www/html/index.php",
      "sudo yum install php php-mysql php-common -y",
      "sudo systemctl start httpd.service",
      "sudo systemctl enable httpd.service",
      "cd /var/www/html/",
      "sudo rm *",
      "sudo setfacl -R -m u:ec2-user:rwx /var/www/html"
    ]
  }

}

resource "null_resource" "up_web_app" {
  count = var.instance_count
  depends_on = [
    null_resource.sync_server
  ]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = aws_instance.server[count.index].public_ip
    private_key = file("keys/kp_privkey_iac_ec2.pem")
  }


  provisioner "file" {
    source      = "files/web_application/"
    destination = "/var/www/html"
  }
}