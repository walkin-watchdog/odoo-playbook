# Server setup using ansible

## Clone this repo locally

## Folder structure
```text
inventory/
    group_vars/
        all/
            all.yaml
    hosts
templates/
    docker-compose.yml.j2
    Dockerfile
    entrypoint.sh
    odoo.conf.j2
    odoo_pg_pass.j2
    docker-compose.yml-2.j2
    Dockerfile-2
    entrypoint-2.sh
    odoo.conf-2.j2
    odoo_pg_pass-2.j2
enterprise/
nginx-proxy/
    nginx.conf
    cors.conf
setup.yaml  # setup the server from scratch
```

## 1. Install ansible on the host system
```bash
brew install ansible
```

## 2. Copy host's SSH keys over to the remote server using SSH
```bash
ssh-copy-id root@12.34.56.78 # remote server's IP address
```

## 3. Clone/Download this repo locally

## 4. Navigate to the repo directory on the host system using Command Line.

## 5. Edit the config files `inventory/hosts` and `inventory/group_vars/all/all.yaml` to setup the remote server from scratch

```text
# Example hosts file

[servers]   # group name
ra-odoo ansible_host=12.34.56.78 ansible_user=root
```

```text
# Example hosts file

actual_domain: yourdomain.com
letsencrypt_email: mail@yourdomain.com
actual_domain_2: yourdomain2.com
letsencrypt_email_2: mail@yourdomain2.com
addons_repo: github-user/addons.git
addons_test_repo: github-user/addons-test.git
odoo_db_master_pass: odoo_master_pass_db
pg_db_pass: postgresdbpass
github_token: token
```

## 6. Ensure the Odoo 18 Enterprise Patch is correctly placed in the enterprise directory and run the playbook to setup the remote server
```bash
ansible-playbook setup.yaml
```