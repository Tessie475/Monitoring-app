# Google Cloud provider configuration
provider "google" {
  credentials = file(var.credentials)
  project     = var.project_id
  region      = var.gcp_region
}

# define provider (google) version and minimum terraform version
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.5.0"
    }
  }

  required_version = ">= 1.6"
}
