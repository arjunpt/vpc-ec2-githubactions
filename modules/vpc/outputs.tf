output "vpc_id" {
    value = aws_vpc.my_vpc.id
}
output "subnet_id" {
    value = aws_subnet.mysubnet.*.id #* — means "for all instances" created with count or for_each. and ".id — extract the ID of each subnet."
}