resource "google_storage_bucket" "function_source" {
  name     = "${var.project_id}-function-source"
  location = var.region

  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "function_source" {
  name   = "function-source.zip"
  bucket = google_storage_bucket.function_source.name
  source = "function-source.zip"
}

resource "google_cloudfunctions2_function" "app_function" {
  name     = "gcp-demo-function"
  location = var.region

  build_config {
    runtime     = "nodejs22"
    entry_point = "helloHttp"

    source {
      storage_source {
        bucket = google_storage_bucket.function_source.name
        object = google_storage_bucket_object.function_source.name
      }
    }
  }

  service_config {
    available_memory   = "256M"
    timeout_seconds    = 60
    max_instance_count = 2

    environment_variables = {
      PROJECT_ID = var.project_id
    }
  }
}