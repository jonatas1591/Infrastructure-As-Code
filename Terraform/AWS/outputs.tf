/*output "public_ip" {
  value = aws_instance.server.public_ip
}

output "instance_state" {
  value = aws_instance.server.password_data
}

output "vpc_id" {
  value = aws_vpc.vpc_iac.id
}
*/

output "instance_dns" {
  value = "${join(",", aws_instance.server.*.public_dns)}"
}
