output "name" {
  value       = aws_db_instance.web.name
}

output "user" {
  value       = aws_db_instance.web.username
}

output "password" {
  value       = aws_db_instance.web.password
}

output "host" {
  value       = aws_db_instance.web.address
}

output "port" {
  value       = aws_db_instance.web.port
}