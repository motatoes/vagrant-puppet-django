# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.


require 'yaml'

PUPPET_FACTERS = YAML.load_file('puppet/conf.yaml')


Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"


  config.ssh.username = "vagrant"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
   config.vm.network "forwarded_port", guest: 80, host: 8080
   config.vm.network "forwarded_port", guest: 8080, host: 8000

  # == synced folders == #
  ## Note: due to an issue of vagrant trying to mount this nonexistant folder before provisioning, as a workaround I comment this line before I do the first vagrnant up, and then I uncomment it thereafter so that the project folder is mounted ...

### TODO: Find a better way to sort this issue
  # config.vm.synced_folder PUPPET_FACTERS["PROJECTNAME"], "/home/#{PUPPET_FACTERS['PROJECTNAME']}", owner: PUPPET_FACTERS['USERNAME']

# == Provisioning == # config.vm.provision "shell" do |shell| 
  config.vm.provision "shell" do |shell|
    shell.path = "install_puppet_modules.sh"
  end

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
     puppet.facter = PUPPET_FACTERS 
     puppet.manifest_file = "site.pp"
 end


end


