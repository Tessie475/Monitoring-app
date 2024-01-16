# Create a Cloud Storage bucket
resource "google_storage_bucket" "my_bucket" {
  name     = var.bucket_name
  location = var.gcp_region
  project  = var.project_id
}

# Fetch information about the created bucket
data "google_storage_bucket" "my_bucket_info" {
  name = google_storage_bucket.my_bucket.name
}

# Pub/Sub topic for user visits
resource "google_pubsub_topic" "user_visits_topic" {
  name = var.topic_name
}

# Create a metric based on the execution count
resource "google_monitoring_metric_descriptor" "cloud_function_execution_count_metric" {
  metric_kind = "GAUGE"
  value_type  = "INT64"
  description = "Metric for Cloud Function execution count"
  type = "custom.googleapis.com/cloud_function_execution_count"
  display_name = "Cloud Function Execution Count Metric"
  labels {
    key         = var.function_name
    value_type  = "STRING"
    description = "Name of the auto scale function"
  }
}

# Configure an email notification channel
resource "google_monitoring_notification_channel" "email_channel" {
  display_name = "email-notification"
  type         = "email"

  labels = {
    email_address = var.email_address
  }
}

# Monitoring and alerting resources
resource "google_monitoring_alert_policy" "cloud_function_execution_count_alert" {
  display_name          = "cloud-function-execution-count-alert"
  notification_channels = [google_monitoring_notification_channel.email_channel.name]
  combiner              = "AND"

  conditions {
    display_name        = "Execution count condition"
    condition_threshold {
      filter            = "metric.type=\"cloudfunctions.googleapis.com/function/execution_count\" AND resource.type=\"cloud_function\""
      comparison        = "COMPARISON_GT"
      duration          = "60s"
      threshold_value   = 0.17
      aggregations {
        alignment_period = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }
}
