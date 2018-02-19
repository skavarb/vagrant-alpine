begin
  require 'vagrant'
rescue LoadError
  raise 'The Vagrant Alpine Linux Guest plugin must be run within Vagrant.'
end

if Vagrant::VERSION < '1.7.0'
  fail 'The vagrant-alpine plugin is only compatible with Vagrant 1.7+'
end

module VagrantPlugins
  module GuestAlpine
    class Plugin < Vagrant.plugin('2')
      name 'Alpine guest'
      description 'Alpine Linux guest support.'

      guest('alpine', 'linux') do
        require File.expand_path('../guest', __FILE__)
        Guest
      end

      guest_capability('alpine', 'configure_networks') do
        require_relative 'cap/configure_networks'
        Cap::ConfigureNetworks
      end

      guest_capability('alpine', 'halt') do
        require_relative 'cap/halt'
        Cap::Halt
      end

      guest_capability('alpine', 'change_host_name') do
        require_relative 'cap/change_host_name'
        Cap::ChangeHostName
      end

      guest_capability('alpine','mount_virtualbox_shared_folder') do
        require_relative "cap/mount_virtualbox_shared_folder"
        Cap::MountVirtualBoxSharedFolder
      end

      guest_capability('alpine', 'nfs_client_install') do
        require_relative 'cap/nfs_client'
        Cap::NFSClient
      end

      guest_capability('alpine', 'rsync_installed') do
        require_relative 'cap/rsync'
        Cap::RSync
      end

      guest_capability('alpine', 'rsync_install') do
        require_relative 'cap/rsync'
        Cap::RSync
      end
    end
  end
end
