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
}