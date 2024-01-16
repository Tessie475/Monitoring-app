variable "credentials" {
  description = "Path to the GCP credentials file"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
  
}

variable "gcp_region" {
  description = "GCP region"
  type        = string
  
}

variable "email_address" {
    description = "Email address"
    type = string
}

variable "function_name" {
    description = "Cloud_Function Function Name"
    type = string
}

variable "topic_name" {
    description = "Pub sub topic name"
    type = string
}

variable "bucket_name" {
    description = "Cloud storage bucket name"
    type = string
}