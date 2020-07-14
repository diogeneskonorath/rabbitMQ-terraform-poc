# Configure the Docker provider

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Create a container

resource "docker_image" "rabbitmq" {
	name = "rabbitmq:3.8.4-management"
}

resource "docker_container" "rabbitmq" {
	image = "${docker_image.rabbitmq.name}"
	name = "rabbitmq"

	env = ["RABBITMQ_DEFAULT_USER=guest", "RABBITMQ_DEFAULT_PASS=guest"]

    ports {
        internal = 15672
        external = 15672
        ip = "172.17.0.1"
    }
    ports {
        internal = 5672
        external = 5672
    }

	restart = "always"
}

