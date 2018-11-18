# -*- mode: ruby -*-
# vi: set ft=ruby :

SrcFolder = "imas-lyric-analyser"

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
    vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
  end

  config.vm.synced_folder "./", "/home/vagrant/"+SrcFolder, type: "virtualbox", create: true

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y build-essential autoconf automake libtool libtool-bin
    apt-get install -y ruby ruby-dev
    apt-get install -y mecab libmecab-dev mecab-ipadic-utf8 mecab-jumandic-utf8

    git clone https://github.com/taku910/crfpp
    cd crfpp
    sed -i '/#include "winmain.h"/d' crf_test.cpp
    sed -i '/#include "winmain.h"/d' crf_learn.cpp
    ./configure
    make
    make install
    ldconfig
    cd ..

    git clone https://github.com/taku910/cabocha
    cd cabocha
    libtoolize --force
    aclocal
    autoheader
    automake --force-missing --add-missing
    autoconf
    ./configure --with-charset=UTF-8
    make
    make check
    make install
    ldconfig
    cd ..

    echo "UTF-8" > /usr/local/lib/cabocha/model/charset-file.txt

    cd #{SrcFolder}
    gem install mecab cabocha --no-ri --no-rdoc
    cd ..
  SHELL
end
