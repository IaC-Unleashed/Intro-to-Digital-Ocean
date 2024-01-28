data "digitalocean_ssh_key" "pixelbook" {
  name = "pixelbook"
}

data "digitalocean_project" "iac_unleashed" {
  name = "IaC Unleashed"
}

resource "digitalocean_droplet" "iac_test_server" {
  image  = var.droplet_image
  name   = "iac-test-server"
  region = var.region
  size   = var.droplet_size
  ssh_keys = [
    data.digitalocean_ssh_key.pixelbook.id,
  ]
  tags = [
    "test"
  ]
}

resource "digitalocean_project_resources" "iac_unleashed_project" {
  project = data.digitalocean_project.iac_unleashed.id
  resources = [
    digitalocean_droplet.iac_test_server.urn
  ]
}

resource "digitalocean_firewall" "iac_test_firewall" {
  name = "iac-test-firewall"

  droplet_ids = [digitalocean_droplet.iac_test_server.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "80"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "443"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

output "public_ip_server" {
  value = digitalocean_droplet.iac_test_server.ipv4_address
}