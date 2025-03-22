terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# You can find schema and type of each param here
# https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image
resource "docker_image" "modelserving" {
  name         = "modelserving:latest"
  keep_locally = true
  build {
    context = "."
  }
}

# You can find the schema and type of each param here
# https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/container
resource "docker_container" "modelserving" {
  image = docker_image.modelserving.image_id
  name  = "model_serving_container"

  # Type: (Block List)
  ports {
    internal = 1234
    external = 1234
  }

  # Type: (String)
  working_dir = "/home/model_serving" 

  # Type: (List of String). If this does not break up spaces by a new string, IT WILL FAIL!
  command = ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "1234"] 

  # For all intents and purposes, Block Set would be defined similarly to Block List
  # Type: (Block Set)
  volumes {
    container_path = "/home/model_serving"
    host_path = "/home/darren/Documents/terraform-task/model_serving"
  }

  volumes {
    container_path = "/home/model_serving/someotherdir"
    host_path = "/home/darren/Documents"
  }  

  # Type: (Map of String) - just here as an example
  # log_opts = {
  #   "max-size" = "10m"          # Limit the size of each log file
  #   "max-file" = "3"            # Keep only the latest 3 log files
  #   "compress" = "true"         # Enable log compression
  # }
}
