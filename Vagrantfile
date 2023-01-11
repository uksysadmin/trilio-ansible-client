# -*- mode: ruby -*-
# vi: set ft=ruby :

# Interfaces
# eth0 - nat (used by VMware/VirtualBox)
# eth1 - hostbased ip

nodes = {
    'ansible'  => [1, 20],
}

Vagrant.configure("2") do |config|

  # Defaults (VirtualBox)
  config.vm.box = "bento/ubuntu-20.04"
  config.vm.synced_folder ".", "/vagrant", type: "nfs"

  #Default is 2200..something, but port 2200 is used by forescout NAC agent.
  config.vm.usable_port_range = 2800..2900

  config.vm.graceful_halt_timeout = 120

  nodes.each do |prefix, (count, ip_start)|
    count.times do |i|
      hostname = "%s" % [prefix, (i+1)]

      config.ssh.insert_key = false

      config.vm.define "#{hostname}" do |box|
        box.vm.hostname = "#{hostname}.cook.book"
        box.vm.network :private_network, ip: "192.168.56.#{ip_start+i}", :netmask => "255.255.248.0"

        box.vm.provision :shell, :path => "#{prefix}.sh"

        # VirtualBox Config
        box.vm.provider :virtualbox do |vbox|
          vbox.name = "#{hostname}"
          # Defaults
          vbox.linked_clone = true if Vagrant::VERSION =~ /^1.8/
          vbox.customize ["modifyvm", :id, "--memory", 4096]
          vbox.customize ["modifyvm", :id, "--cpus", 1]
          vbox.customize ["modifyvm", :id, "--nicpromisc1", "allow-all"]
          vbox.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
        end
      end
    end
  end
end
