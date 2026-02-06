output "public_ip" {
  value = module.ec2.public_ip
}

output "pem_file" {
  value = module.ec2.pem_file
}
