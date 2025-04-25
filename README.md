# K3S_Optiplex_Cluster_Project
## Background
Distributed computing systems play a massive role in today's technology industries. Since it's not always feasible to have a singular powerful machine, the ability to utilize many smaller machines and combine the processing power for containerized programs has been made possible thanks to technologies like Kubernetes and Docker Swarm. 

After taking an applied distributed computing course while working on my master's degree in computer science, I wanted to build a distributed compute cluster for myself using affordable equipment such as micro form factor computers such as the Dell Optiplex or Lenovo ThinkCentre.

## Project Plan
I settled on the Dell Optiplex 7050. I was able to get ahold of three devices on eBay that came with 8GB of RAM and a single-threaded 4-core i5-6500T processor I upgraded each to 16GB and storage in the form of a 128GB NVME SSD. Overall, each device cost me about $60 after the upgrades. Forthe load balancer, I decided to use a Raspberry Pi 4 that I had laying around from a previous project. Network-wise, I utilized my Ubiquiti Unifi home network in the form of a Unifi Dream Machine Pro and USW 24 port POW switch. For software, I opted to utilize the lighter weight Rancher K3s Kubernetes variant since I didn’t have a whole lot of computing power to begin with. Despite the fact that the machines were fairly underpowered, I decided to use Proxmox as a hypervisor on each machine instead of installing to bare metal since I knew I would inevitably make break something and I wanted to be able to quickly and remotely spin up a new VM as opposed to having to reinstall the OS at the machines.

### Hardware Overview
3× Dell Optiplex 7050

  * i5-6500T CPU
  * 16GB RAM
  * 128GB NVMe SSD

1× Raspberry Pi 4 (load balancer)

### Software Overview
  * Proxmox VE 8.4
  * Ubuntu Server 24.04.2 AMD64 (for the Optiplex machines)
  * Rancher K3S
  * Ubuntu Server 24.04.2 ARM64 (for RPi4)

<img src="images/PXL_20250418_185342523.jpg" width="400">

