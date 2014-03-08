class x_puppet (
  $certname = $::hostname,
  $release  = 'production',
  $puppet_server = 'puppet',
) {

  file { '/etc/puppetlabs/puppet/puppet.conf':
    ensure  => file,
    content => template('x_puppet/puppet-agent.conf.erb'),
    owner   => 'pe-puppet',
    group   => 'pe-puppet',
  }

  file { '/etc/profile.d/puppet.sh':
    ensure  => file,
    content => 'PATH=$PATH:/opt/puppet/bin'
  }
}