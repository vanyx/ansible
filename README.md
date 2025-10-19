# Ansible Lab

Contient mes playbooks & roles Ansible.  
  
Il inclut également un **conteneur Docker simple prêt à l’emploi**, configuré pour tester Ansible via SSH.

## Docker

Le conteneur Docker permet de simuler une machine Linux distante.

- **Utilisateur** : `ansiblelab`  
- **Mot de passe** : `password`  
- **Port SSH exposé** : 2222

**1. Générer une clé SSH dédiée pour le lab :**
```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa_ansible_lab
```

**2. Build et run le conteneur :**
```bash
docker build -t ansible-lab .
docker run -d -p 2222:22 ansible-lab
ssh-copy-id -i ~/.ssh/id_rsa_ansible_lab.pub -p 2222 ansiblelab@localhost
```

**3. Le conteneur est maintenant accessible en SSH sur le localhost via :**
```bash
ssh -i ~/.ssh/id_rsa_ansible_lab -p 2222 ansiblelab@localhost
```