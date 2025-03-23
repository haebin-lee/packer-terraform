output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = module.ec2.bastion_public_ip
}

output "private_instance_private_ips" {
  description = "Private IPs of the private instances"
  value       = module.ec2.private_instance_private_ips
} 