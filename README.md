# Intro to Digitalocean #

## Overview ##

This project will cover the creation of a basic cloud server on a platform called Digitalocean. This will be accomplished using an IaC technology called Terraform. This project assumes you already have Terraform installed on your machine. If not, check out their offical site at https://developer.hashicorp.com/terraform/install. Though some familiarity would help with understanding Terraform, it is not strictly necessary here. I'll try to explain everything as best I can as we go.

Here is a referal link to Digitalocean. If you set up an account using it, you'll get $200 in credit over 60 days. And after that, I'll get $25 in credit if you spend $25 or more.

[![DigitalOcean Referral Badge](https://web-platforms.sfo2.cdn.digitaloceanspaces.com/WWW/Badge%201.svg)](https://www.digitalocean.com/?refcode=b2ef32b53bbc&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge)

---

## Digitalocean ##

Digitalocean is a cloud hosting provider that offers cloud computing services and Infrastructre as a Service (IaaS). I find it to be a developer-friendly platform that provides services such as compute, storage, data, and network services. Following along with this project assumes you have an account set up with Digitalocean. Don't worry, you'll get free credits to use during this exploratory phase. In fact, part of the reason I advocate so heavily for IaC is because it allows us to stand up a machine, webserver, VPC, or whatever we need instantly, consistently, and lasting only for as long as we need it. We can tailor the exact specification of our needs and manifest them through simple commands, backed by the blueprint of the infrastructure, written in code. So for this project, we will only create a very small virtual machine (VM), which will only be in existence for moments. We will create this instance, explore it, then tear it down. As we become more adept at this, we can use other technologies to provision these VMs with specific capabilities, such as serving as a webserver, vpn, gateway, storage bucket, and more. But before we can fly, we must first be able to run...

---

## The *terraform.tfvars* File ##

Note that the `terraform.tfvars` file does not exist in the repository. This file is protected from version control with `.gitignore`. This file needs to be created in the project's root directory, and the ssh key and personal access token detailed below should be placed inside it. A sample template for this file is included in the repo, as `terraform.tfvars.template`. Simply substiute your own values for the variables (including the brackets), then remove the `.template` extension from the file name.

---

## Adding SSH Keys to Digitalocean ##

In order for this project to work, you'll need to generate an SSH key pair and drop the public key in Digitalocean. After creating a new key pair with `ssh-keygen` or something similar, go to the **Settings** -> **Security** tab and add the new key. Once you add the key, you'll need to remember the name you gave it and copy the fingerprint provided by Digitalocean. You'll need to place the copied values into the `terraform.tfvars` file like so:

```hcl
ssh_key_fingerprint = "[copied_fingerprint]"
ssh_key_name = "[ssh_key_name_from_do]"
```

---

## Adding a Personal Access Token to Digitalocean ##

Similarly, a Personal Access Token (PAT) needs to be created on DigitalOcean for connecting to the API. This can be found on the **API** -> **Tokens** tab. Make sure the scope is set to Read and Write, and be sure to copy the token once it is created, because you'll never get to see it again. Once copied, place the token in the `terraform.tfvars` file like so:

```hcl
do_token = "[personal_access_token]"
```

---

## Initializing and Launching the Project ##

Once the project is cloned to your local machine and the steps above have been followed, navigate a terminal to the `terraform` directory and initialize the terraform project:

```shell
$ terraform init
```

If terraform has been successfully intialized, check the plan by running:

```shell
$ terraform plan
```

If this looks okay, you can spin up the cloud machines any time by applying the plan:

```shell
$ terraform apply
```

You'll have to type `yes` in order to confirm the process. It'll take a little time to create the cloud machine and build up the firewall. But once it's done, the newly-created machine's IP address should be listed in the terminal that ran the terraform as `public_ip_server`. If all goes as expected, your VM is ready for you to ssh into and explore.

---

## VM Details ##

This process creates a VM on Digital Ocean with the following properties:

- **Image:** Debian 11 x64
- **Size:** 1 Intel vCPU, 2 GB Memory
- **Storage:** 50 GB disk
- **Region:** NYC1
- **Firewall:** Inbound: SSH, ICMP; Outbound: HTTP, HTTPS, DNS, ICMP
- **Cost:** $0.018/hour

---

## Exploring the VM ##

Now to verify that your machine is up and running, you can check it in your Digitalocean dashboard under your project's resources. You can also attempt to SSH into your VM remotely. Just take the `public_ip_server` IPv4 address returned by Terraform and run the command:

```shell
$ ssh root@public_ip_server
```

Make sure to type `yes` to add the IP address to the known hosts, which will then allow you to proceed to the VM:

```shell
Linux iac-test-server 5.10.0-23-amd64 #1 SMP Debian 5.10.179-1 (2023-05-12) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
root@iac-test-server:~#
```

Congratulations! You now have an active VM that you can explore, use, scale, or tear down whenever you're done. Even better, you now have a proven, reliable method of spinning up a VM whenever you need it simply by running a couple of commands. Eventually we'll look at custom provisioning these VMs for specific use cases, as well as learning more about building a network ifrastructure all from code.

---

## Destroying the VM ##

To destroy and tear down the infrastructure. Simply use the following command in the terraform directory:

```shell
    terraform destroy
```

Any time you want to redeploy the VM, simply run the `terraform plan` and `terraform apply` commands again.