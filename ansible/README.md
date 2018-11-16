# Deployment

* Ubuntu 18

Prepare user:

  - ssh to-machine
  - `adduser ubuntu --disabled-password`
  - `adduser ubuntu sudo`
  - `usermod -aG sudo ubuntu`
  - `sudo visudo` (edit in nano mode): %sudo   ALL=(ALL:ALL) NOPASSWD: ALL
  - paste the public key into `/home/ubuntu/authorized_keys`

Ansible usage:
```
 ansible-playbook staging.yml -i hosts
```
