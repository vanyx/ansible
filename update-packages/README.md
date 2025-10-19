# Update Packages

Ce playbook vérifie **pour chaque groupe de hosts** si les packages spécifiés sont à jour.  
Possibilité de mettre à jour les packages si la variable `update_deprecated` vaut **true** pour le groupe.

## Configuration

- Modifier les **groupes** dans l'inventory
- Modifier les **packages** et **update_deprecated** pour chaque groupe dans `group_vars/`

## Run

```bash
ansible-playbook -i inventory/hosts playbook.yml
```

## Amélioration
Supporter les serveurs utilisant yum/dnf (RedHat/CentOS/Fedora)