output "internal_ip_address_tf0" {
  value = "${yandex_compute_instance.tf-0.network_interface.0.ip_address}"
}

output "external_ip_address_tf0" {
  value = "${yandex_compute_instance.tf-0.network_interface.0.nat_ip_address}"
}