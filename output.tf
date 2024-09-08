output "ec2_id" {
  value = aws_instance.web.id
}

output "sg_id" {
  value = aws_security_group.allow_ssh_https.id
}

