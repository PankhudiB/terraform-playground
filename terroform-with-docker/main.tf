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
    internal = var.int_port
  }
}