variable "ami_id_demo1" {
  type = string
  description = " The ami id of the ec2 instance (Optional )"
  default = "ami-02e136e904f3da870"
}

variable "ec2_instance_type" {
  description = "Instance type of the aws ec2 instance."
  default = "t2.micro"
}

variable "create_ec2_instance_check" {
  default = "false"
}