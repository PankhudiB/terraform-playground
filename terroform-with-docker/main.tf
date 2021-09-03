module "image" {
  source = "./image"
}

resource "random_string" "random" {
  count = 2
  length = 4
  special = false
  upper = false
}

resource "docker_container" "nodered_container" {
  count = 2
  image = module.image.image_out
  name = join("-",["nodered",random_string.random[count.index].result])
  ports {
    internal = var.int_port
  }
}