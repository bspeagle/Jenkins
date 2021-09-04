output "id" {
  description = "Random generated Id"
  value       = random_id.this.hex
}

output "pet_name" {
  description = "Random generated pet name"
  value       = "${random_pet.this.id}-${random_id.this.hex}"
}

output "password" {
  description = "Random generated password"
  value       = random_string.this.result
}
