variable "project" {
  default     = "Data-Engineering"
  type        = string
  description = "Name of project"
}

variable "environment" {
  default     = "Data-Engineering-Seminars-Playground"
  type        = string
  description = "Name of environment"
}

variable "database_password" {
  default     = "qwerty123"
  type        = string
  description = "Database password inside storage engine"
}

variable "database_username" {
  default     = "postgres"
  type        = string
  description = "Name of user inside storage engine"
}

variable "database_name" {
  default     = "de_pgdb"
  type        = string
  description = "Name of the database inside storage engine"
}

variable "backup_retention_period" {
  default     = 0
  type        = number
  description = "Number of days to keep database backups"
}

variable "backup_window" {
  default     = "04:00-04:30"
  type        = string
  description = "60 minute time window to reserve for maintenance"
}

variable "maintenance_window" {
  default     = "sun:04:30-sun:05:30"
  type        = string
  description = "60 minute maintenance window"
}

variable "auto_minor_version_upgrade" {
  default     = true
  type        = bool
  description = "Minor engine upgrades are applied automatically to the DB instance during the maintenance windows"
}

variable "snapshot_identifier" {
  default     = ""
  type        = string
  description = "The name of the snapshot (if any) the database should be created from"
}

variable "final_snapshot_identifier" {
  default     = "terraform-aws-postgresql-rds-snapshot"
  type        = string
  description = "Identifier for final snapshot if skip_final_snapshot is set to false"
}

variable "skip_final_snapshot" {
  default     = true
  type        = bool
  description = "Flag to enable or disable a snapshot if the database instance is terminated"
}

variable "copy_tags_to_snapshot" {
  default     = false
  type        = bool
  description = "Flag to enable or disable copying instance tags to the final snapshot"
}

variable "multi_availability_zone" {
  default     = false
  type        = bool
  description = "Flag to enable hot standby in another az"
}

variable "database_port" {
  default     = 5432
  type        = number
  description = "Port on which database will accept connections"
}

variable "vpc_id" {
  type        = string
  description = "ID of VPC meant to house the database"
}

variable "subnet_group" {
  type        = string
  description = "Database subnet group"
}

variable "parameter_group" {
  default     = "default.postgres11"
  type        = string
  description = "Database engine parameter group"
}

variable "storage_type" {
  default     = "gp2"
  type        = string
  description = "Type of underlying storage for database. The default is SSD for general purpose."
}

variable "storage_encrypted" {
  default     = false
  type        = bool
  description = "Flag to enable storage encryption"
}

variable "deletion_protection" {
  default     = false
  type        = bool
  description = "Flag to protect the database instance from deletion"
}

variable "cloudwatch_logs_exports" {
  default     = ["postgresql", "upgrade"]
  type        = list(any)
  description = "List of logs to publish to Cloudwatch logs"
}

variable "allocated_storage" {
  default     = 5
  type        = number
  description = "Storage allocated to database instance"
}

variable "database_identifier" {
  type        = string
  description = "Database identifier"
}

variable "engine" {
  default     = "postgres"
  type        = string
  description = "Database type"
}

variable "engine_version" {
  default     = "11.9"
  type        = string
  description = "Database engine version"
}

variable "instance_type" {
  default     = "db.t2.micro"
  type        = string
  description = "Instance type for database instance"
}

variable "publicly_accessible" {
  default     = false
  type        = bool
  description = "Flag to set whether the db is publicly accessible"
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "Extra tags to attach to the RDS resources"
}
