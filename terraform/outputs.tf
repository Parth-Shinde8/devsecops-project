output "public_ip" {
  value = aws_instance.devsecops_ec2.public_ip
}

output "ssh_command" {
  value = "ssh ubuntu@${aws_instance.devsecops_ec2.public_ip}"
}