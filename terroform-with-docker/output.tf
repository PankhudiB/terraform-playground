
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