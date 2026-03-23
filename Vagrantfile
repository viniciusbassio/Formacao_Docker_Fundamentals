Vagrant.configure("2") do |config|

  # Box base (Ubuntu leve)
  config.vm.box = "ubuntu/focal64"

  # Desabilitar sync folder (opcional, melhora desempenho)
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Script para instalar Docker
  docker_install = <<-SHELL
    apt-get update -y
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

    add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

    apt-get update -y
    apt-get install -y docker-ce

    usermod -aG docker vagrant
    systemctl enable docker
    systemctl start docker
  SHELL

  # ========================
  # MASTER (Manager)
  # ========================
  config.vm.define "master" do |master|
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "192.168.56.10"

    master.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 2
    end

    master.vm.provision "shell", inline: docker_install

    # Inicializa o Swarm
    master.vm.provision "shell", inline: <<-SHELL
      docker swarm init --advertise-addr 192.168.56.10

      # Salva o token de worker em arquivo compartilhado
      docker swarm join-token -q worker > /vagrant/worker_token
    SHELL
  end

  # ========================
  # NODES (Workers)
  # ========================
  nodes = [
    { name: "node01", ip: "192.168.56.11" },
    { name: "node02", ip: "192.168.56.12" },
    { name: "node03", ip: "192.168.56.13" }
  ]

  nodes.each do |node|
    config.vm.define node[:name] do |n|
      n.vm.hostname = node[:name]
      n.vm.network "private_network", ip: node[:ip]

      n.vm.provider "virtualbox" do |vb|
        vb.memory = 512
        vb.cpus = 1
      end

      n.vm.provision "shell", inline: docker_install

      # Entrar no cluster como worker
      n.vm.provision "shell", inline: <<-SHELL
        # Aguarda o master gerar o token
        while [ ! -f /vagrant/worker_token ]; do
          sleep 5
        done

        TOKEN=$(cat /vagrant/worker_token)

        docker swarm join --token $TOKEN 192.168.56.10:2377
      SHELL
    end
  end

end
