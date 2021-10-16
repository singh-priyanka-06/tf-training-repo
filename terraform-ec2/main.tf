resource "aws_instance" "demo_ec2_1" {
  ami = var.ami_id_demo1
  instance_type = var.ec2_instance_type
  # count = 2
  count = var.create_ec2_instance_check =="true"? 1:0
}





