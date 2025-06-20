variable "vpc_cidr" {
  type = string
  description = "vpc cidr range"
  
}
variable "subnet_cidr" {
    description = "subnet cidr"
    type = list(string)
  
}

