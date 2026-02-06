output "public_ip" {
  value = aws_instance.strapi_ec2.public_ip
}

output "pem_file" {
  value = local_file.pem_key.filename
}
