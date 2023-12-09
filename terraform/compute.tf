#Get the ubuntu ami
data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# Create ssh_key
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#Create a key pair
resource "aws_key_pair" "instance_key" {
  key_name = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Cerate IAM instace profile
resource "aws_iam_instance_profile" "app_profile" {
  name= "ec2-profile-for-ecr"
  role = "ec2-ecr-auth"
}
# Create an instance

resource "aws_instance" "app_instance" {
  #subnet_id = aws_subnet.project_public_subnet[0]
  ami= data.aws_ami.server_ami.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.instance_key.key_name
  #vpc_security_group_ids = [aws_security_group.app_sg.id]
  iam_instance_profile = aws_iam_instance_profile.app_profile.name
  connection {
    type = "ssh"
    host = self.public_ip
    user = "ubuntu"
    private_key = tls_private_key.ssh_key.private_key_openssh
  }

  tags = {
    name = "app_server"
  }
}


resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.app_instance.id
  allocation_id = "eipalloc-0bf37d8bc49556885"
}



/* resource "aws_security_group" "app_sg" {
  name        = "public_instances_sg"
  description = "Security group for public instances"
  vpc_id      = aws_vpc.project_vpc.id

}

resource "aws_security_group_rule" "ingress_all" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = -1
  cidr_blocks       = [var.access_ip]
  security_group_id = aws_security_group.app_sg.id
}

resource "aws_security_group_rule" "engress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_sg.id
}
 */
output "instance_public_ip" {
    value = aws_instance.app_instance.public_ip
    sensitive = true
} 

output "ssh_private" {
  value = tls_private_key.ssh_key.private_key_openssh
  sensitive = true
}
