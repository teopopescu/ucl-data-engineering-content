data "aws_security_group" "selected" {
  filter {
    name   = "group-name"
    values = ["security_group"]
  }
}
data "aws_db_subnet_group" "vpc_subnet_group" {
  name = "data_engineering_subnet_group_eu_west_2"
}




resource "aws_db_instance" "pgdb" {
  allocated_storage               = var.allocated_storage
  engine                          = var.engine
  engine_version                  = var.engine_version
  identifier                      = var.database_identifier
  snapshot_identifier             = var.snapshot_identifier
  instance_class                  = var.instance_type
  storage_type                    = var.storage_type
  name                            = var.database_name
  password                        = var.database_password
  username                        = var.database_username
  backup_retention_period         = var.backup_retention_period
  backup_window                   = var.backup_window
  maintenance_window              = var.maintenance_window
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  final_snapshot_identifier       = var.final_snapshot_identifier
  skip_final_snapshot             = var.skip_final_snapshot
  copy_tags_to_snapshot           = var.copy_tags_to_snapshot
  multi_az                        = var.multi_availability_zone
  port                            = var.database_port
  parameter_group_name            = var.parameter_group
  storage_encrypted               = var.storage_encrypted
  deletion_protection             = var.deletion_protection
  enabled_cloudwatch_logs_exports = var.cloudwatch_logs_exports
  publicly_accessible             = var.publicly_accessible
  vpc_security_group_ids          = [data.aws_security_group.selected.id]
  db_subnet_group_name            = data.aws_db_subnet_group.vpc_subnet_group.id

  tags = merge(
    {
      Name        = "DatabaseServer",
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}
output "database_endpoint" {
  value = aws_db_instance.pgdb.endpoint
}
output "database_password" {
  value = aws_db_instance.pgdb.password
}
output "database_port" {
  value = aws_db_instance.pgdb.port
}
output "database_name" {
  value = aws_db_instance.pgdb.name
}
