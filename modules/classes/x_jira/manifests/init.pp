class x_jira (
  $java_home = '/usr/lib/jvm/java',
) {

  class { 'jira':
    version     => '6.2.1',
    installdir  => '/opt',
    homedir     => '/var/local/jira',
    user        => 'jira',
    group       => 'jira',
    dbpassword  => 'secret',
    dbserver    => 'localhost',
    javahome    => $java_home,
    downloadURL => 'http://www.atlassian.com/software/jira/downloads/binary',
    require     => Class['java'],
  }
}