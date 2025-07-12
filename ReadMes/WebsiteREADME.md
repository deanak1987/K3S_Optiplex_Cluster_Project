# WordPress Website Setup
We are going to setup our very own self-hosted website and run it on our k3s cluster!
## Setup
First we will setup the namespace, followed by WordPress & MySQL db passwords for the site's security and then create a secret in kubectl to access the passwords.
```bash
kubectl create namespace wordpress
export WP_PASSWORD=$(openssl rand -base64 32)
export MYSQL_WP_PASSWORD=$(openssl rand -base64 32)
export MYSQL_ROOT_PASSWORD=$(openssl rand -base64 32)
echo "Generated passwords - MySQL Root: $MYSQL_ROOT_PASSWORD"
echo "WordPress: $WP_PASSWORD"
echo "WordPress DB: $MYSQL_WP_PASSWORD"

kubectl create secret generic mysql-secret \
  --from-literal=wordpress-password="$WP_PASSWORD" \
  --from-literal=mariadb-root-password="$MYSQL_ROOT_PASSWORD" \
  --from-literal=mariadb-password="$MYSQL_WP_PASSWORD" \
  -n wordpress
```

Next, install WordPress via Helm

```bash
helm install wordpress bitnami/wordpress   --namespace wordpress   --values wordpress-values.yaml
```

If you ever need to uninstall the site, simply run:
```bash
helm uninstall wordpress  --namespace wordpress
```


