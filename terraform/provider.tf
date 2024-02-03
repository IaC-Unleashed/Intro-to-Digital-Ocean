# file: terraform/provider.tf

# List of required providers for this project
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.34.1"
    }
  }
}

# Configure the DigitalOcean provider
provider "digitalocean" {
  token = var.do_token
}