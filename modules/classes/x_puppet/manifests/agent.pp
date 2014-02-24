class x_puppet::agent (
  $puppet_server = 'master',
) inherits x_puppet {

  file { '/etc/puppetlabs/puppet/puppet.conf':
    content => template('x_puppet/puppet-agent.conf.erb'),
    notify  => Service['pe-httpd'],
  }

}