resource "aws_db_instance" "stop_run_away" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  db_name              = "stoprunaway"
  username             = "stoprunaway"
  password             = ""
  publicly_accessible  = true
  skip_final_snapshot  = true
  parameter_group_name = aws_db_parameter_group.stop_run_away.name
  vpc_security_group_ids = [ aws_security_group.stop_run_away_db.id ]

  tags = {
    Name = "StopRunAwayDB"
  }
}

resource "aws_db_parameter_group" "stop_run_away" {
  name        = "stop-run-away-db-parameter-group"
  family      = "mysql8.0"

  parameter {
    name  = "time_zone"
    value = "Asia/Seoul"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }
  
  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "collation_connection"
    value = "utf8mb4_general_ci"
  }
}

resource "aws_security_group" "stop_run_away_db" {
  name        = "stop_run_away-db-security-group"

  ingress {
    description = "MySQL"
    from_port   = 3306
    to_port     = 3306
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
    Name = "StopRunAwayDBSecurityGroup"
  }
}