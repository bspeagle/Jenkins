output "id" {
  value = aws_vpc.this.id
}

output "subnets" {
  value = aws_subnet.this.*.id
}