# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'optparse'

# Read commandline args
#cmd_options = OptionParser.new do |opts|
#  opts.on('--[no-]update', TrueClass, 'Update der Services durchführen') do |do_update|
#    update_services = do_update
#  end
#end

# Catch parsing errors for vagrant args like --provision
begin
# Read the args
  cmd_options.parse!
rescue StandardError => exception
# Catch and ignore
end

# Vagrant min. Version
Vagrant.require_version '>= 2.2.4'

# Configre Vagrant
Vagrant.configure('2') do |config|
    # https://docs.vagrantup.com.
    config.vagrant.plugins = ['vagrant-disksize', 'vagrant-hosts', 'vagrant-auto_network']

    # Use Ubuntu 20.04
    config.vm.box = 'dev-vm_ubuntu-20.04'
    #config.vm.box = 'dev-vm-ubuntu-18'

    config.vm.define "DevVM"
    
    # Check for Updates on start up
    #config.vm.box_check_update = true

    # Rause HDD size from deafault 10GB to 40GB
    #config.disksize.size = '40GB'

    # Use bash as default ssh shell
    #config.ssh.shell = 'bash'
    
    # Configure network
    config.vm.network :private_network, auto_network: true
    config.vm.network "forwarded_port", guest: 8080, host: 8080
    config.vm.network "forwarded_port", guest: 443, host: 443

    # Folder sync host-guest
    config.vm.synced_folder 'share', '/share'
      
    # Setup VM
    config.vm.provider 'virtualbox' do |vb|
      vb.check_guest_additions = true
      #vb.cpus = 4
      vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", "8192"]
      # Set the number of virtual CPUs for the virtual machine
      vb.customize ["modifyvm", :id, "--cpus", "4"]
      vb.customize ["modifyvm", :id, "--graphicscontroller", "vboxvga"]
      vb.customize ["modifyvm", :id, "--vram", "128"]
      # Enabling the I/O APIC is required for 64-bit guest operating systems;
      # it is also required if you want to use more than one virtual CPU in a VM.
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      # Enable the use of hardware virtualization extensions (Intel VT-x or AMD-V) in the processor of your host system
      vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
      # Enable, if Guest Additions are installed, whether hardware 3D acceleration should be available
      vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
      # Enable USB
      vb.customize ["modifyvm", :id, "--usb", "on"]
      # Customize shares
      vb.customize ["modifyvm", :id, "--clipboard-mode", "bidirectional"]
      vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]

      #Add CD Drive
      vb.customize ["storageattach", :id,
                    "--storagectl", "IDE Controller",
                    "--port", "0", "--device", "1",
                    "--type", "dvddrive",
                    "--medium", "emptydrive"]

    end

    ######################
    # Beginn Provisioner #
    ######################

    #config.vm.provision 'intellij-community',  type: 'shell', run: 'once', inline: <<-SHELL
    #    sudo apt-get update && sudo apt-get install -y ubuntu-desktop
    #SHELL

    # Update the system and install all necessary tools
    #config.vm.provision 'init-tools',  type: 'shell', run: 'once', path: './install.sh'

    # Install IntelliJ Community Edition
    #config.vm.provision 'intellij-c',  type: 'shell', run: 'once', inline: <<-SHELL
    #    sudo snap install intellij-idea-community --classic
    #SHELL

    # Init jhipster example app
    #config.vm.provision 'init-jhipster-example',  type: 'shell', run: 'once', inline: <<-SHELL
    #    sudo curl -L 'https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)' -o /usr/local/bin/docker-compose
    #    chmod +x /usr/local/bin/docker-compose
    #    ln -sfn /usr/local/bin/docker-compose /usr/bin/docker-compose
    #SHELL

    # Init example app
    #config.vm.provision 'init-example',  type: 'shell', run: 'once', inline: <<-SHELL
    #    sudo curl -L 'https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)' -o /usr/local/bin/docker-compose
    #    chmod +x /usr/local/bin/docker-compose
    #    ln -sfn /usr/local/bin/docker-compose /usr/bin/docker-compose
    #SHELL


  config.vm.provision 'init-german',  type: 'shell', run: 'always', inline: <<-SHELL
        #Set bash keyboard to german
        #sudo sed -i 's/XKBLAYOUT=\"\w*"/XKBLAYOUT=\"'de'\"/g' /etc/default/keyboard

        #Set gnome keyboard to german
        #echo 'sudo gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'de')]"' > /home/vagrant/.profile
  SHELL
end
