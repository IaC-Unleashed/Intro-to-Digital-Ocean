variable "do_token" {
  description = "DigitalOcean API Token"
}

variable "ssh_key_fingerprint" {
  description = "Fingerprint of the public key stored on DigitalOcean"
}

variable "ssh_key_name" {
  description = "Name of the ssh key on DigitalOcean"
}

variable "region" {
  description = "DigitalOcean Region"
  default     = "nyc1"
}

variable "droplet_image" {
  description = "DigitalOcean droplet image name"
  default     = "debian-11-x64"
}

variable "droplet_size" {
  description = "Droplet size for server"
  default     = "s-1vcpu-2gb-intel"
}