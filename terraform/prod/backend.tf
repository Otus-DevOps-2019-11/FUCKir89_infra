terraform {
  required_version = ">=0.12.8"
  backend "gcs" {
    bucket = "storage-bucket-otus-ilya-prod"
    prefix = "terraform/state"
  }
}
