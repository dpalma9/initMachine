**USER MANUAL**
=================

Overview
-------

This is a personal project to install things in my personal computer after install a Debian distro.
You can install packages from the bash script or the ansible reciepe.

Bash script
-------

In order to know how to use and what to can install, execute the script help:

```
./init.sh -h|-H|--help
```


Ansible
-----
> **Note:** You need to install ansible before use it: 
```
sudo apt install -y ansible
```
Usage:

```
ansible-playbook playbook.yml -b -t my_tag1,mytag2
```



