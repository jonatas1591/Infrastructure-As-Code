output "instance_dns" {
  value = join(",", aws_instance.server.*.public_dns)
}

output "load_balance_dns" {
  value = aws_lb.lb_iac.dns_name
}
