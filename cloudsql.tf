resource "google_sql_database_instance" "mssql" {
  name             = "devops-mssql"
  database_version = "SQLSERVER_2022_STANDARD"
  region           = var.region

  root_password = var.sql_root_password

  settings {
    tier              = "db-custom-2-7680"
    availability_type = "ZONAL"

    disk_type       = "PD_SSD"
    disk_size       = 20
    disk_autoresize = true

    backup_configuration {
      enabled = true
    }

    ip_configuration {
      ipv4_enabled = true
    }
  }

  deletion_protection = false
}