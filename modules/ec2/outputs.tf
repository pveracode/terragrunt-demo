output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.main.id
}

output "instance_type" {
  description = "Instance type"
  value       = aws_instance.main.instance_type
}
