# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  # Wooden ships on the water. Very free. And Easy.

  # Every Vagrant virtual environment requires a box to build off of.
  # Use multi VM syntax
  config.vm.define :kalabox do |kalabox|
    kalabox.vm.box = "kalabox"
    kalabox.vm.hostname = "kala.box"

    # The url from where the 'config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
    kalabox.vm.box_url = "http://files.vagrantup.com/precise64.box"

    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    # config.vm.network :forwarded_port, guest: 80, host: 8080

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    kalabox.vm.network :private_network, ip: "192.168.42.10"
    kalabox.hostsupdater.aliases = ["start.kala", "php.kala", "grind.kala"]

    # Create a public network, which generally matched to bridged network.
    # Bridged networks make the machine appear as another physical device on
    # your network.
    # config.vm.network :public_network

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    kalabox.vm.synced_folder "~/kalabox/www", "/var/www", :create => true, :nfs => true
    kalabox.vm.synced_folder "~/kalabox/drush", "/var/www/.drush", :create => true, :nfs => true

    # Set some SSH config
    # config.ssh.username = "kala"
    # kalabox.ssh.host = "kalabox"
    # kalabox.ssh.forward_agent = true

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    # Example for VirtualBox:
    #

    kalabox.vm.provider :virtualbox do |vb|
    #   # Don't boot with headless mode
    #   vb.gui = true
    #
    #   # Use VBoxManage to customize the VM. For example to change memory:
          vb.customize ["modifyvm", :id, "--memory", "2048"]
          vb.name = "Kalabox"
    end
    #
    # View the documentation for the provider you're using for more
    # information on available options.

    # Enable provisioning with Puppet stand alone.  Puppet manifests
    # are contained in a directory path relative to this Vagrantfile.
    # You will need to create the manifests directory and a manifest in
    # the file precise64.pp in the manifests_path directory.
    #
    # An example Puppet manifest to provision the message of the day:
    #
    # # group { "puppet":
    # #   ensure => "present",
    # # }
    # #
    # # File { owner => 0, group => 0, mode => 0644 }
    # #
    # # file { '/etc/motd':
    # #   content => "Welcome to your Vagrant-built virtual machine!
    # #               Managed by Puppet.\n"
    # # }
    #

    # Common data for any provisioner.
    @facter_hash = {
      "vagrant" => "1",
      "kalauser" => "vagrant",
      "kalahost" => "192.168.42.1",
    }

    # General kalabox setup.
    kalabox.vm.provision :shell do |shell|
      shell.path = "scripts/kalabox-setup.sh"
    end

    # Use `puppet apply` via :puppet provisioner when solo-mode flag set.
    # (Double-bang converts `nil` to false.)
    if !!ENV['KALA_SOLO']
      kalabox.vm.provision :shell do |shell|
        shell.path = "scripts/puppet-solo-setup.sh"
      end

      kalabox.vm.provision :puppet do |puppet|
        puppet.manifest_file  = "site.pp"
        #puppet.options = "--verbose --debug"
        puppet.module_path    = "puppet/modules"
        puppet.manifests_path = "puppet/manifests"
        puppet.facter = @facter_hash
      end
    else
      kalabox.vm.provision :shell do |shell|
        shell.path = "scripts/puppet-server-setup.sh"
      end

      kalabox.vm.provision :puppet_server do |puppet|
        puppet.puppet_server = "kalabox.kalamuna.com"
        puppet.options = "--verbose --debug --test"
        puppet.facter = @facter_hash
      end
    end


    # Enable provisioning with chef solo, specifying a cookbooks path, roles
    # path, and data_bags path (all relative to this Vagrantfile), and adding
    # some recipes and/or roles.
    #
    # config.vm.provision :chef_solo do |chef|
    #   chef.cookbooks_path = "../my-recipes/cookbooks"
    #   chef.roles_path = "../my-recipes/roles"
    #   chef.data_bags_path = "../my-recipes/data_bags"
    #   chef.add_recipe "mysql"
    #   chef.add_role "web"
    #
    #   # You may also specify custom JSON attributes:
    #   chef.json = { :mysql_password => "foo" }
    # end

    # Enable provisioning with chef server, specifying the chef server URL,
    # and the path to the validation key (relative to this Vagrantfile).
    #
    # The Opscode Platform uses HTTPS. Substitute your organization for
    # ORGNAME in the URL and validation key.
    #
    # If you have your own Chef Server, use the appropriate URL, which may be
    # HTTP instead of HTTPS depending on your configuration. Also change the
    # validation key to validation.pem.
    #
    # config.vm.provision :chef_client do |chef|
    #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
    #   chef.validation_key_path = "ORGNAME-validator.pem"
    # end
    #
    # If you're using the Opscode platform, your validator client is
    # ORGNAME-validator, replacing ORGNAME with your organization name.
    #
    # If you have your own Chef Server, the default validation client name is
    # chef-validator, unless you changed the configuration.
    #
    #   chef.validation_client_name = "ORGNAME-validator"
  end
end
