output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = aws_instance.bastion.public_ip
}

output "private_instance_private_ips" {
  description = "Private IPs of the private instances"
  value       = aws_instance.private[*].private_ip
} 