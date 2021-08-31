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

resource "random_string" "random" {
  count = 2
  length = 4
  special = false
  upper = false
}

resource "docker_container" "nodered_container" {
  count = 2
  image = docker_image.nodered_image.latest
  name = join("-",["nodered",random_string.random[count.index].result])
  ports {
    internal = 1880
  }
}

output "IP-Address" {
  value       = [for i in docker_container.nodered_container[*] : i.ip_address]
  description = "IP Address"
}

output "ip-and-port" {
  value       = [for i in docker_container.nodered_container[*] : join(":", [i.ip_address], i.ports[*]["external"])]
  description = "IP Address and port - using tf func and for loop"
}

output "container-name" {
  value       = [for i in docker_container.nodered_container[*] : i.name]
  description = "container name"
}
