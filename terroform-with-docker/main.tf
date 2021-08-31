terraform {
  required_providers {
    docker = {
      source = "terraform-providers/docker"
      version = "~> 2.7.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "docker_container" "nodered_container" {
  image = docker_image.nodered_image.latest
  name = "nodered"
  ports {
    internal = 1880
    external = 1880
  }
}

output "IP-Address" {
  value = docker_container.nodered_container.ip_address
  description = "IP Address"
}

output "ip-and-port" {
  value = join(":", [docker_container.nodered_container.ip_address, docker_container.nodered_container.ports[0].external])
  description = "IP Address and port - using tf func"
}