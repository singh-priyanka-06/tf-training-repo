output "ami_id" {
  value = data.aws_ami.latest_ec2_linux.id
}

output "instance_id" {
  value = data.aws_instance.ec2_instance_id.id
}