#!/bin/bash

# Create dynamic environment structure
[[ -d /etc/puppetlabs/puppet/environments ]] || mkdir /etc/puppetlabs/puppet/environments
[[ -d /etc/puppetlabs/puppet/environments/production ]] || mkdir /etc/puppetlabs/puppet/environments/production

# Copy demo modules
[[ -d /vagrant/puppet-gonzo-demo ]] && cp -r /vagrant/puppet-gonzo-demo/* /etc/puppetlabs/puppet/environments/production/

# Set path so gem provider is found
export PATH=$PATH:/opt/puppet/bin

# Initial run to configure hiera
puppet apply \
   --modulepath=/etc/puppetlabs/puppet/environments/production/modules/classes \
   -e 'include x_puppet::master'

# Hiera changes need to be picked up
service pe-httpd restart

# Apply the rest of the role, assigned in site.pp
puppet agent -t --server $(hostname -f)

# Remove default module structure
# TODO: was causing problems with Passenger
# [[ -d /etc/puppetlabs/puppet/modules ]] && rm -rf /etc/puppetlabs/puppet/modules
# [[ -d /etc/puppetlabs/puppet/manifests ]] && rm -rf /etc/puppetlabs/puppet/manifests