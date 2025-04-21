dell optplex 7050 pve node 1 terraform api key faa22132-e2b5-49da-a964-4d0478e99d6c

nodes = [
  {
    name     = "optiplex01"
    host     = "192.168.1.174"
    node     = "pve"
    vm_id    = 101
    hostname = "vm-optiplex01"
	proxmox_terraform_api_token_secret = "${env("PROXMOX_TERRAFORM_NODE1_API_TOKEN")}"
  },
  {
    name     = "optiplex02"
    host     = "192.168.1.175"
    node     = "pve2"
    vm_id    = 102
    hostname = "vm-optiplex02"
	proxmox_terraform_api_token_secret = "${env("PROXMOX_TERRAFORM_NODE2_API_TOKEN")}"
  },
  {
    name     = "optiplex03"
    host     = "192.168.1.176"
    node     = "pve3"
    vm_id    = 103
    hostname = "vm-optiplex03"
	proxmox_terraform_api_token_secret = "${env("PROXMOX_TERRAFORM_NODE3_API_TOKEN")}"
  }
]
