output "public_instance_ip" {
  value = module.alex_ec2.public_ip
}

output "private_instance_ip" {
  value = module.alex_ec2.private_ip
}

output "vpc_id" {
  value = module.alex_vpc.vpc_id
}
