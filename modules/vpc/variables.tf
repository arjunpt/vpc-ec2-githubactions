variable "vpc_cidr" {
  type = string
  description = "vpc cidr range"
  
}
variable "subnet_cidr" {
    description = "subnet cidr"
    type = list(string)
  
}
variable "subnet_name" {
  description = "subnet name"
  type = list(string)
  default = [ "publisubnet1", "publicsubnet2" ]
}