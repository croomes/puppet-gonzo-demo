class x_puppet::master (
  $puppet_server = 'master',
  $dns_alt_names = 'master,puppet',
  $reporturl     = 'https://localhost:443/reports/upload',
  $enc_server    = 'localhost',
) inherits x_puppet {

  service { 'pe-httpd':
    ensure => running,
  }

  File['/etc/puppetlabs/puppet/puppet.conf'] {
    content => template('x_puppet/puppet-master.conf.erb'),
    notify  +> Service['pe-httpd'],
  }

  package { 'hiera-http':
    ensure   => installed,
    provider => gem,
    notify   => Service['pe-httpd'],
  }

  file { '/etc/puppetlabs/puppet/hiera.yaml':
    ensure  => file,
    content => template('x_puppet/hiera.yaml.erb'),
    notify  => Service['pe-httpd'],
  }
 
}