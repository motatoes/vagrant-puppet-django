# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"


  config.ssh.username = "vagrant"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
   config.vm.network "forwarded_port", guest: 80, host: 8080
   config.vm.network "forwarded_port", guest: 8080, host: 8000

  # == synced folders == #
   config.vm.synced_folder "coupmonitor_main", "/home/coupmonitor/coupmonitor_main", owner:"vagrant"

  # == Provisioning == # 
  config.vm.provision "shell" do |shell| 
    shell.path = "install_puppet_modules.sh"
  end

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "site.pp"

    puppet.module_path = ["puppet/modules"]

    #puppet.module_path = ["puppet/modules", "/etc/puppet/modules", "/usr/share/puppet/modules"]
  end

end


