#output "app_external_ip" {
#  value = "${module.gce-lb-http.external_ip}"
#}
#output "app_external_ip" {
#  value = google_compute_instance.app.network_interface[0].access_config[0].nat_ip
#}
