variable project {
  description = "Project ID"
}
variable region {
  description = "Region"
  default     = "europe-west1"
}
variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable privat_key_path {
  description = "Path to the private key used for ssh access"
}
variable disk_image {
  description = "Disk image"
}
variable app_name {
  description = "Name for application; the name is prefix for all app-related resources too"
}
variable instance_count {
  description = "Count of VMs in instance group"
  type        = number
  default     = 1
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
