#!/bin/bash

# Create dynamic environment structure
[[ -d /etc/puppetlabs/puppet/environments ]] || mkdir /etc/puppetlabs/puppet/environments
[[ -d /etc/puppetlabs/puppet/environments/production ]] || mkdir /etc/puppetlabs/puppet/environments/production

# Symlink demo modules for development
[[ -d /etc/puppetlabs/puppet/environments/development ]] || \
  ln -s /vagrant/puppet-gonzo-demo /etc/puppetlabs/puppet/environments/development

# Disable firewall
chkconfig iptables off
service iptables stop

# Set path so gem provider is found
export PATH=$PATH:/opt/puppet/bin

# Initial run to configure hiera
FACTER_release=development \
puppet apply \
  --modulepath=/etc/puppetlabs/puppet/environments/development/modules/classes \
  -e 'include x_puppet::master'

# Remove old site.pp
[[ -f /etc/puppetlabs/puppet/manifests/site.pp ]] && rm /etc/puppetlabs/puppet/manifests/site.pp

# Hiera changes need to be picked up
service pe-httpd restart

# Apply the rest of the role, assigned in site.pp
puppet agent -t --server $(hostname -f)