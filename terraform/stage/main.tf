terraform {
  # Версия terraform
  required_version = ">=0.12.18"
}

provider "google" {
  # Версия провайдера
  version = "2.15"
  # ID проекта
  project = var.project
  region  = var.region
}

module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
  privat_key_path = var.privat_key_path
  zone            = var.zone
  app_disk_image  = var.app_disk_image
}

module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  privat_key_path = var.privat_key_path
  zone            = var.zone
  db_disk_image   = var.db_disk_image
}

module "vpc" {
  source          = "../modules/vpc"
  public_key_path = var.public_key_path
  zone            = var.zone
  db_disk_image   = var.db_disk_image
  source_ranges   = ["0.0.0.0/0"]
}
resource "template_file" "dynamic_inventory" {
  template = file("dynamic_inventory.json")
  vars = {
    app_ext_ip = "${module.app.app_external_ip}"
    db_ext_ip  = "${module.db.db_external_ip}"
  }
}