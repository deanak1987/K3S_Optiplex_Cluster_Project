# WordPress Website Setup
We are going to setup our very own self hosted website and run it on our k3s cluster!
## Setup
First we will setup the namespace and a MySQL db for the site's data to be stored on
```bash
kubectl create namespace wordpress
kubectl apply -f mysql-deployment.yaml
```