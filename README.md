# dev-suite

This suite consists of a pre-built virtual machine with all necessary tools for application development with Java and NodeJs.
During the build with Packer the OS will be updated to the latest version.

Until now only VirtualBox and Ubuntu have been implemented. 
Other OS and maybe other virtualization products will follow.

**Including:**
* Ubuntu 20.4.1
* Gnome Desktop
* Docker
* Docker Compose
* KubeCtl
* Java 11 LTS (AdoptOpenJDK)
* NodeJS 12 LTS
* IntelliJ Community Edition

## Quickstart
Install following tools to use all features. Install Packer if you will build a custom box.  

* [Vagrant](https://www.vagrantup.com/downloads.html)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Packer](https://www.packer.io/downloads.html) (The packer binary should be available on your PATH)

* User: `vagrant`
* Password: `vagrant`

#### VM usage
* Boot: `vagrant up`
* Access: Via GUI or `vagrant ssh`

#### VM creation
* Build: `packer build -only=virtualbox-iso packer/ubuntu/ubuntu-20.04-amd64.json`

* Add new box: `vagrant box add --name=dev-vm_ubuntu-20.04 --force packer/builds/dev-vm_ubuntu-20.04.virtualbox.box`

#### Defaults
Default settings can be changed in the Vagrantfile:

* Forwarded ports:
  * guest: 8080, host: 8080
  * guest: 3443, host: 3443
  
* Shared folder:
  * ./share

Default settings can be changed in the Vagrantfile:

#### Replace IntelliJ-Community with Ultimate version
Run the following command after the vm is up:
`vagrant provision --provision-with intellij-ultimate`