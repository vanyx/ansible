# Sonare - Deployment

Ce playbook/roles Ansible me permet de configurer le backend de mon app `Sonare` :
- Configuration du serveur
- Installation des composants
- Déploiement/run du backend (BDD, API, crons python)

Cela me permet ainsi, sur demande, de rapidement configurer le serveur et de déployer le backend de l'app.


## Prérequis

**1. Nom de domaine :**  
Le domaine doit exister et pointer vers l’adresse IP du serveur où l’application sera déployée.  
  
**2. Accès SSH root :**  
Un utilisateur ayant accès en ssh avec les droits **sudo** est nécessaire pour l'exécution du playbook.

**3. Configurer l'accès en SSH via clé :**
- L’accès ssh au serveur doit être configuré avec une clé privée/clé publique.
- La clé privée correspondante doit être disponible sur la machine depuis laquelle Ansible sera exécuté.

**4. Accès au repo Git en SSH :**
- Le repository Git contenant le backend va être cloné via SSH sur le serveur. S'assurer alors qu'une clé SSH sur Git est configuré, et disponible sur la machine depuis laquelle Ansible sera exécuté.

**5. Configurer le site web statique :**
- S'assurer qu'il y a bien un **roles/nginx/files/index.html** et l'icon de l'app dans **roles/nginx/files/icon.png**.


## Run

**Fichier hosts (à modifier) :**
```ini
backend ansible_host=YOUR_HOST ansible_port=22 ansible_user=CHANGEME ansible_ssh_private_key_file=CHANGEME
```

**Playbook (à modifier) :**
```yml
- name: Sonare - Deployement
  hosts: backend
  become: true
  roles:
    - firewall
    - nginx
    - create-deploy-user
    - deploy-backend

  vars:
    site_name: "sonare" # Name of the site, used for Nginx directory and config
    domain_name: "CHANGEME" # Domain name for the site, used for Nginx and SSL
    ssl_email: "CHANGEME" # Email used by Certbot to register SSL certificates
    deploy_user: deploy # System user created for deployment
    deploy_group: deploy # Group associated with the deploy user
    repo_name: sonare-backend # Name of the folder where the Git repository will be cloned
    repo_url: "CHANGEME" # SSH URL of the backend Git repository
    repo_branch: main # Git branch to clone
    git_local_ssh_key: "CHANGEME" # Path to the SSH private key used by Ansible to clone the repo
```

**Run :**
```bash
ansible-playbook -i hosts playbook.yml
```

## Roles

- **firewall**  
  Configures the server firewall (UFW) and Fail2Ban to secure SSH and Nginx, including rules for HTTP, HTTPS, DNS, and brute-force protection.

- **nginx**  
  Installs and configures Nginx to serve the static website and reverse-proxy requests to the backend API. Also sets up SSL certificates with Let's Encrypt (Certbot) and enforces HTTPS.

- **create-deploy-user**  
  Creates a dedicated deployment user (`deploy_user`) with a home directory, adds it to the Docker group, and optionally allows Docker commands via sudo without a password.

- **deploy-backend**  
  Sets up the backend application: clones the Git repository, ensures the deploy user has SSH access, and runs the application with Docker Compose, rebuilding containers from scratch if needed.