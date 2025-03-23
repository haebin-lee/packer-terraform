aws_region = "us-east-1"
project_name = "packer-terraform"
vpc_cidr = "10.0.0.0/16"
ami_id = "ami-08b5b3a93ed654d19"  # TODO: AMI created by Packer
instance_type = "t2.micro"
allowed_ip = "0.0.0.0/0"          # TODO: CHANGE THIS TO YOUR IP
private_instance_count = 6
