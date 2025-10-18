terraform {
  required_providers {
    docker = {
      source  = "docker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

module "docker_compose" {
  source = "lukechilds/docker-compose/docker"
  compose_files = ["${path.module}/docker-compose.yml"]
}