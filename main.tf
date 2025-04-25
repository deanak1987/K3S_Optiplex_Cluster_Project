provider "proxmox" {
  pm_api_url      = "https://${var.host}:8006/api2/json"
  ssh_user        = "root"
  ssh_private_key = file("~/.ssh/id_rsa")
}

variable "vm_names" {
  type    = list(string)
  default = ["k3s-master0", "k3s-worker0", "k3s-worker1"]
}

variable "proxmox_nodes" {
  type    = list(string)
  default = ["proxmox-node1", "proxmox-node1", "proxmox-node2"]  # Adjust if needed
}

variable "proxmox_terraform_api_token_secret" {
  description = "Proxmox Terraform API token secret"
  type        = string
}

resource "proxmox_vm_qemu" "k3s_nodes" {
  count       = 3
  name        = var.vm_names[count.index]
  target_node = var.proxmox_nodes[count.index]
  
  clone = "ubuntu-template"  # Use a prebuilt Ubuntu cloud image template

  cpu    = "host"
  cores  = 3
  memory = 12000
  sockets = 1

  disk {
    size    = "20G"
    type    = "virtio"
    storage = "local-lvm"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y curl"
    ]
  }

  # Install K3s Master
  provisioner "remote-exec" {
    when    = "create"
    on_failure = continue
    inline = [
      "if [ \"${var.vm_names[count.index]}\" = \"k3s-master0\" ]; then",
      "  curl -sfL https://get.k3s.io | sh -",
      "  sudo cat /var/lib/rancher/k3s/server/node-token > /tmp/node-token",
      "fi"
    ]
  }

  # Install K3s Workers and Join Them to Master
  provisioner "remote-exec" {
    when    = "create"
    on_failure = continue
    inline = [
      "if [[ \"${var.vm_names[count.index]}\" =~ k3s-worker ]]; then",
      "  K3S_TOKEN=$(ssh root@k3s-master0 'sudo cat /var/lib/rancher/k3s/server/node-token')",
      "  MASTER_IP=$(ssh root@k3s-master0 'hostname -I | awk \"{print \$1}\"')",
      "  curl -sfL https://get.k3s.io | K3S_URL=https://$MASTER_IP:6443 K3S_TOKEN=$K3S_TOKEN sh -",
      "fi"
    ]
  }
}
