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
      vb.gui = true
      # Set memory
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

    config.vm.provision 'intellij-ultimate',  type: 'shell', run: 'never', inline: <<-SHELL
        sudo snap remove intellij-idea-community
        sudo snap install intellij-idea-ultimate --classic
    SHELL

    config.vm.provision 'install-lens',  type: 'shell', run: 'never', inline: <<-SHELL
        #https://snapcraft.io/install/kontena-lens/ubuntu
        sudo snap install kontena-lens --classic
    SHELL
end
