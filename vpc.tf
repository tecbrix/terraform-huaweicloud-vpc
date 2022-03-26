# Create a VPC
resource "huaweicloud_vpc" "base_vpc" {
  name = var.vpc_name
  cidr = var.vpc_cidr
}
#Subnet
resource "huaweicloud_vpc_subnet" "subnet" {
  vpc_id        = huaweicloud_vpc.base_vpc.id
  name          = var.subnet_name
  cidr          = var.subnet_cidr
  gateway_ip    = var.subnet_gateway
  primary_dns   = var.primary_dns
  secondary_dns = var.secondary_dns
}
#EIP
resource "huaweicloud_vpc_eip" "nat" {
  publicip {
    type = var.eip_type
  }
  bandwidth {
    name        = "NAT"
    size        = var.eip_size
    share_type  = var.eip_share_type
    charge_mode = var.eip_charge_mode
  }
}
#NAT
resource "huaweicloud_nat_gateway" "nat" {
  name      = var.nat_name
  spec      = "1"
  vpc_id    = huaweicloud_vpc.base_vpc.id
  subnet_id = huaweicloud_vpc_subnet.subnet.id
}
#SNAT
resource "huaweicloud_nat_snat_rule" "snat" {
  nat_gateway_id = huaweicloud_nat_gateway.nat.id
  floating_ip_id = huaweicloud_vpc_eip.nat.id
  subnet_id      = huaweicloud_vpc_subnet.subnet.id
}
