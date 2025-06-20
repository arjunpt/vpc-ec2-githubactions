resource "aws_security_group" "sg" {
  name        = "sg"
  description = "allow http ssh traffic"
  vpc_id      = var.vpc_id


  ingress {
    description = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] #this is for public acess
  }
  ingress {
    description = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] #this is for public acess
  }
    
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"] #this is for public acess
  }
  tags = {
    Name = "security group"
  }
}