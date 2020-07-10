# Configure the RabbitMQ provider

provider "rabbitmq" {
  endpoint = "http://127.0.0.1:15672"
  username = "guest"
  password = "guest"
}

# Create a virtual host

resource "rabbitmq_vhost" "host" {
  name = "host"
}

# Configure the rabbitmq_queue

resource "rabbitmq_permissions" "guest" {
  user  = "guest"
  vhost = "${rabbitmq_vhost.host.name}"

  permissions {
    configure = ".*"
    write     = ".*"
    read      = ".*"
  }
}

resource "rabbitmq_queue" "bmf-queue" {
  name  = "bmf-queue"
  vhost = "${rabbitmq_permissions.guest.vhost}"

  settings {
    durable     = false
    auto_delete = true
  }
}



