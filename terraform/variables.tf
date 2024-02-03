variable "do_token" {
  description = "Digitalocean API Token"
}

variable "ssh_key_fingerprint" {
  description = "Fingerprint of the public key stored on Digitalocean"
}

variable "ssh_key_name" {
  description = "Name of the ssh key on Digitalocean"
}

variable "region" {
  description = "Digitalocean Region"
  default     = "nyc1"
}

variable "droplet_image" {
  description = "Digitalocean droplet image name"
  default     = "debian-11-x64"
}

variable "droplet_size" {
  description = "Droplet size for server"
  default     = "s-1vcpu-2gb-intel"
}