# Sonare - Deployement

Ce playbook/roles Ansible me permet de configurer le backend de mon app 'Sonare' :
- Configuration du serveur
- Installation des composants
- Déploiement/run du backend (BDD, API, crons python)

Cela me permet ainsi, sur demande, de déployer rapidement le backend de l'app.

## Prérequis

**1. Nom de domaine :**  
Le domaine doit exister et pointer vers l’adresse IP du serveur où l’application sera déployée.  
  
**2. Accès SSH root :**  
Un utilisateur ayant accès en ssh avec les droits **sudo** est necessaire pour l'execution du playbook.

**3. Configurer l'accès en SSH via clé :**
- L’accès ssh au serveur doit être configuré avec une clé privée/clé publique.
- La clé privée correspondante doit être disponible sur la machine depuis laquelle Ansible sera exécuté.

## Run

**Fichier hosts (à modifier) :**
```ini
backend ansible_host=YOUR_HOST ansible_port=22 ansible_user=YOUR_USER ansible_ssh_private_key_file=~/.ssh/PRIVATE_KEY
```

**Playbook (à modifier) :**
```ini
- name: Sonare - Deployement
  hosts: backend
  become: true
  roles:
    - firewall
    - docker
    # - @TODO : deployer l'app
    # - @TODO : configurer cron
    - nginx
    - ssl
  vars:
    site_name: "sonare"
    domain_name: "YOUR_DOMAINE"
    ssl_email: "YOUR_EMAIL_ADDRESS"
```

## Détails techniques

@TODO