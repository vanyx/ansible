# Ansible

Contient mes projets Ansible.  
  
Il inclut également un **lab Docker simple prêt à l’emploi**, configuré pour des tests Ansible via SSH sur plusieurs hosts.

## Docker Lab

Met à disposition 4 nodes, pour simuler des machines Linux distantes.

- **Utilisateur** : `ansiblelab`
- **Mot de passe** : `password`  

**1. Générer une clé SSH dédiée pour le lab :**
```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa_ansible_lab
```

**2. Run :**
```bash
docker compose up -d
```

**3. Se connecter au moins une première fois sur chaque node :**
```bash
ssh -i ~/.ssh/id_rsa_ansible_lab ansiblelab@localhost -p 2221

-- puis :
ssh -i ~/.ssh/id_rsa_ansible_lab ansiblelab@localhost -p 2222
ssh -i ~/.ssh/id_rsa_ansible_lab ansiblelab@localhost -p 2223
ssh -i ~/.ssh/id_rsa_ansible_lab ansiblelab@localhost -p 2224
```