output "subnetid" {
  value = huaweicloud_vpc_subnet.subnet.id
}

output "vpcid" {
  value = huaweicloud_vpc.base_vpc.id
}

output "vpc_cidr" {
  value = var.vpc_cidr
}