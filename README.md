# Intro to Digitalocean #

## Overview ##

This project will cover the creation of a basic cloud server on a platform called Digitalocean. This will be accomplished using an IaC technology called Terraform. This project assumes you already have Terraform installed on your machine. If not, check out their offical site at https://developer.hashicorp.com/terraform/install. Though some familiarity would help with understanding Terraform, it is not strictly necessary here. I'll try to explain everything as best I can as we go.

Here is a referal link to Digitalocean. If you set up an account using it, you'll get $200 in credit over 60 days. And after that, I'll get $25 in credit if you spend $25 or more.

[![DigitalOcean Referral Badge](https://web-platforms.sfo2.cdn.digitaloceanspaces.com/WWW/Badge%201.svg)](https://www.digitalocean.com/?refcode=b2ef32b53bbc&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge)

## Digitalocean ##

Digitalocean is a cloud hosting provider that offers cloud computing services and Infrastructre as a Service (IaaS). I find it to be a developer-friendly platform that provides services such as compute, storage, data, and network services. Following along with this project assumes you have an account set up with Digitalocean. Don't worry, you'll get free credits to use during this exploratory phase. In fact, part of the reason I advocate so heavily for IaC is because it allows us to stand up a machine, webserver, VPC, or whatever we need instantly, consistently, and lasting only for as long as we need it. We can tailor the exact specification of our needs and manifest them through simple commands, backed by the blueprint of the infrastructure, written in code. So for this project, we will only create a very small virtual machine (VM), which will only be in existence for moments. We will create this instance, explore it, then tear it down. As we become more adept at this, we can use other technologies to provision these VMs with specific capabilities, such as serving as a webserver, vpn, gateway, storage bucket, and more. But before we can fly, we must first be able to run...

## The `terraform.tfvars` File ##

Note that the `terraform.tfvars` file does not exist in the repository. This file is protected from version control with `.gitignore`. This file needs to be created in the project's root directory, and the ssh key and personal access token detailed below should be placed inside it. A sample template for this file is included in the repo, as `terraform.tfvars.template`. Simply substiute your own values for the variables (including the brackets), then remove the `.template` extension from the file name.

## Adding SSH Keys to Digitalocean ##

In order for this project to work, you'll need to generate an SSH key pair and drop the public key in Digitalocean. After creating a new key pair with `ssh-keygen` or something similar, go to the `Settings` -> `Security` tab and add the new key. Once you add the key, you'll need to remember the name you gave it and copy the fingerprint provided by Digitalocean. You'll need to place the copied fingerprint into the `terraform.tfvars` file like so:

```
ssh_key_fingerprint = "[copied_fingerprint]"
```

## Adding a Personal Access Token to Digitalocean ##

Similarly, a Personal Access Token (PAT) needs to be created on DigitalOcean for connecting to the API. This can be found on the `API` -> `Tokens` tab. Make sure the scope is set to Read and Write, and be sure to copy the token once it is created, because you'll never get to see it again. Once copied, place the token in the `terraform.tfvars` file like so:

```
do_token = "[personal_access_token]"
```