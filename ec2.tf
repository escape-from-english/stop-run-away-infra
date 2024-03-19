resource "aws_instance" "stop_run_away" {
  ami           = "ami-09a7535106fbd42d5"
  instance_type = "t2.micro"
  security_groups = [ aws_security_group.stop_run_away.name ]

  tags = {
    Name = "StopRunAwayApplication"
  }
}

resource "aws_security_group" "stop_run_away" {
  name        = "stop_run_away-ec2-security-group"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "StopRunAwayEC2SecurityGroup"
  }
}