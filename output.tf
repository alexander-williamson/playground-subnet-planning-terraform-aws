locals {
  # parent_network.network_number.host
  # 10.0          .0      .0
  base_cidr = "10.1.0.0/16" # the base cidr block 
  bits = 6 # how many bits in decimal (will be converted to binary) to use for the home part of the subnet
  private_subnet_offset = 32 # there are 64 available subnets in 10.1.0.0/16
}

output "private_subnet_1" {
  value = cidrsubnet(local.base_cidr, local.bits, 0)
}

output "private_subnet_2" {
  value = cidrsubnet(local.base_cidr, local.bits, 1)
}

output "private_subnet_3" {
  value = cidrsubnet(local.base_cidr, local.bits, 2)
}

output "public_subnet_1" {
  value = cidrsubnet(local.base_cidr, local.bits, local.private_subnet_offset + 0)
}

output "public_subnet_2" {
  value = cidrsubnet(local.base_cidr, local.bits, local.private_subnet_offset + 1)
}

output "public_subnet_3" {
  value = cidrsubnet(local.base_cidr, local.bits, local.private_subnet_offset + 2)
}