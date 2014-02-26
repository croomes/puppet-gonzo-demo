class x_bamboo (
  $java_home = '/usr/lib/jvm/java',
) {

  class { 'bamboo':
    version    => '5.4.1',
    installdir => '/usr/local',
    home       => '/var/local/bamboo',
    user       => 'bamboo',
    java_home  => $java_home,
    require    => Class['java'],
  }

  # We control Puppet's environments
  file { '/etc/puppetlabs/puppet/environments':
    ensure => directory,
    owner  => 'bamboo',
  }
}