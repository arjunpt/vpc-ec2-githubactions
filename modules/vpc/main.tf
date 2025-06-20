#VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"


}

#subnets
resource "aws_subnet" "mysubnet" {
  count = length(var.subnet_cidr)  #This tells Terraform to create multiple subnets, one for each item in the list.
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.subnet_cidr[count.index] #count.index will be 0, 1, 2… as the resource is created in a loop.
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true #ec2 will get public ip on launch
  tags = {
    Name = var.subnet_name[count.index]
    project = "dac"
    env = "dev"
  }
}

#igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "myigw"
    project = "dac"
    env = "dev"
  }
}

#route table

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0" #public
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Myrt"
    project = "dac"
    env = "dev"
  }
}
#rotue table associaation

resource "aws_route_table_association" "rta" {
  count = length(var.subnet_cidr)  
  subnet_id      = aws_subnet.mysubnet[count.index].id
  route_table_id = aws_route_table.rt.id
}
















###################################
# var.subnet_cidr is a list
# subnet_cidr = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]


# count = length(var.subnet_cidr)
# This tells Terraform to create multiple subnets, one for each item in the list.
# In the example above, length = 3, so Terraform creates 3 subnets.


# cidr_block = var.subnet_cidr[count.index]
# This is the main trick.
# count.index will be 0, 1, 2… as the resource is created in a loop.
# First subnet → cidr_block = var.subnet_cidr[0] → 10.0.1.0/24
# Second subnet → cidr_block = var.subnet_cidr[1] → 10.0.2.0/24
# Third subnet → cidr_block = var.subnet_cidr[2] → 10.0.3.0/24


#data.aws_availability_zones.available.names[count.index] -data.aws_availability_zones.available.names returns a list of available AZs in the current AWS region.count.index helps assign a different AZ to each subnet.
#Name = var.subnet_name[count.index]This assigns a custom name tag to each subnet.
 

# count = length(var.subnet_cidr)
# You're looping this association for every subnet you have — dynamically.

# If you have 3 subnets, Terraform will create 3 aws_route_table_association resources.

# subnet_id = aws_subnet.subnet[count.index].id
# This picks each subnet one by one from the loop:
# aws_subnet.subnet[0] → subnet with CIDR 10.0.1.0/24
# aws_subnet.subnet[1] → subnet with CIDR 10.0.2.0/24
# So when creating route table associations, you refer to them using:
# subnet_id = aws_subnet.subnet[count.index].id

