provider "yandex" {
  token = "${var.yxtoken}"
  cloud_id = "${var.yxcloudid}"
  folder_id = "${var.yxfolderid}"
  zone = "ru-central1-c"
}

// Create a new instance
// https://cloud.yandex.ru/docs/compute/api-ref
resource "yandex_compute_instance" "tf-0" {
  name = "tf0-centos"
  hostname = "tf0-centos"
  description = "description for TF0 virtual machine"

  resources {
    cores  = 1
    memory = 1
  }

  boot_disk {
    initialize_params {
      // yc compute image list --folder-id standard-images | egrep 'STATUS|centos'
      image_id = "fd8u8t05uet8frke86tb"
      size = 10
      name = "tf0-vda"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.tfsubnet-0.id}"
    nat = true
  }

  // ATTENTION!! REMOVE THIS POLICY BEFORE GOING INTO DEV OR PROD ENV
  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
  provisioner "remote-exec" {
    connection {
    type = "ssh"
    host = "${yandex_compute_instance.tf-0.network_interface.0.nat_ip_address}"
    user = "centos"
    private_key = "${file("~/.ssh/id_rsa")}"
    }
  inline = ["cat /etc/*release"]
  }
}

resource "yandex_vpc_network" "tfnetwork-0" {
  name = "tfnetwork0"
}

resource "yandex_vpc_subnet" "tfsubnet-0" {
  name           = "tfsubnet0"
  zone           = "ru-central1-c"
  network_id     = "${yandex_vpc_network.tfnetwork-0.id}"
  v4_cidr_blocks = ["192.168.99.0/25"]
}