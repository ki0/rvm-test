unless Vagrant.has_plugin?("vagrant-vbguest")
  raise 'Vbguest plugin is not installed!'
end

unless Vagrant.has_plugin?("vagrant-hosts")
  raise 'Hosts plugin is not installed!'
end

nodes_config = (JSON.parse(File.read("nodes.json")))['nodes']
id_rsa_ssh_key_pub = File.read(File.join(Dir.home, ".ssh", "id_rsa.pub"))
Vagrant.configure(2) do |config|

  nodes_config.each do |node|
    node_name   = node[0] # name of node
    node_values = node[1] # content of node

    config.vm.define node_name do |config|
      config.vm.box =  node_values[':box']
      config.ssh.insert_key = false
      config.ssh.private_key_path = [ '~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa' ]
      config.ssh.forward_agent = true
      # configures all forwarding ports in JSON array
      ports = node_values['ports']
      ports.each do |port|
        config.vm.network :forwarded_port,
          host:  port[':host'],
          guest: port[':guest']
      end

      config.vm.hostname = node_name
      config.vm.network :private_network, ip: node_values[':ip']
      config.vm.provision :hosts, :sync_hosts => true, :add_localhost_hostnames => false, :autoconfigure => true

      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", node_values[':memory']]
        vb.customize ["modifyvm", :id, "--name", node_name]
      end

      bootstraps = node_values['bootstraps']
      bootstraps.each do |bootstrap|
        config.vm.provision "shell", path: bootstrap, privileged: false
      end
      config.vm.provision "shell", inline: <<-SHELL
        echo "Copying local id_rsa SSH Key to VM auth_keys for auth purposes (login into VM included)..."
        echo '#{id_rsa_ssh_key_pub}' > /home/vagrant/.ssh/authorized_keys
        chmod 600 /home/vagrant/.ssh/authorized_keys
      SHELL

      synced_folders = node_values['synced_folders']
      synced_folders.each do |synced_folder|
        config.vm.synced_folder synced_folder['origin'], synced_folder['destination'],
            create: true, 
            type: "nfs",
            mount_options: ['rw', 'noatime', 'hard', 'timeo=30', 'retrans=2', 'intr', 'rsize=32768', 'wsize=32768'],
            linux__nfs_options: ['no_root_squash', 'rw', 'no_subtree_check','all_squash']	
      end
    end
  end
end
