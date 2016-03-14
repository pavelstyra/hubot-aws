Vagrant.configure(2) do |config|

  def provisioning(config, shell_arguments)
    config.vm.provision "shell", path: "provision.sh", args: shell_arguments
  end

  excludes = [".git/", "myhubot/node_modules"]
  config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: excludes, rsync_excludes: excludes

  config.vm.define "dev" do |dev|
    provisioning(dev, ["dev", "vagrant"])
    dev.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
    dev.vm.box = "debian/contrib-jessie64"
    dev.vm.hostname = "hubot-dev"
    dev.vm.network "private_network", ip: "172.16.0.10"
    dev.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "1"
      end
  end

  config.vm.define "prod" do |prod|
    provisioning(prod, ["prod", "admin"])
    prod.vm.box = "dummy"
    prod.vm.provider "aws" do |aws, override|
      aws.security_groups = "default"
      aws.instance_type = "t2.micro"
      aws.region_config "eu-central-1", :ami => "ami-02b78e1f"
      aws.region_config "eu-west-1", :ami => "ami-e31a6594"
      aws.region = "eu-central-1"

      aws.tags = {
       'Name' => 'Hubot'
      }

      override.ssh.username = "admin"
      aws.keypair_name = ENV['AWS_KEYNAME']
      override.ssh.private_key_path = ENV['AWS_KEYPATH']

      aws.access_key_id = ENV['AWS_KEY']
      aws.secret_access_key = ENV['AWS_SECRET']
    end
  end

end
