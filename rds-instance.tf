resource "aws_db_instance" "rds-mysql" {
    instance_class = "db.t3.micro"
    identifier = "${var.db_name}-mysql"
    engine = "mysql"
    engine_version = "8.0.39"
    allocated_storage = 30
    #vpc_security_group_ids = [aws_security_group.ssh-access]
    username = var.db_username
    password = random_password.rds_mysql_password.result
    skip_final_snapshot = true
}

resource "random_password" "rds_mysql_password" {
  length = 16
  special = false
}

resource "aws_secretsmanager_secret" "rds_mysql_password" {
  name = "${var.prefix}-rds-mysql-password"
}

resource "aws_secretsmanager_secret_version" "rds_mysql_password" {
  secret_id = aws_secretsmanager_secret.rds_mysql_password.id
  secret_string = jsondecode({password = random_password.rds_mysql_password.result})
}

resource "aws_security_group" "rds-sg" {
  vpc_id = aws_vpc.main.id

  ingress{
    protocol = "tcp"
    from_port = 3306
    to_port = 3306
    cidr_blocks = [aws_subnet.private.cidr_block]
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]

  }
}

resource "aws_db_subnet_group" "private-rds" {
  name = "${var.prefix}-db-subnet-group"
  subnet_ids = [aws_subnet.private.id]
}