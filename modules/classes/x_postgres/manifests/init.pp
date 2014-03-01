# == Class: x_postgres
#
# Just for installing devel headers and libraries, not for configuring a server.
#
# Why couldn't PE ship with headers?
#
class x_postgres {

  yumrepo { 'pgdg92':
    descr    => 'PostgreSQL 9.2 $releasever - $basearch',
    baseurl  => 'http://yum.postgresql.org/9.2/redhat/rhel-$releasever-$basearch',
    enabled  => '1',
    gpgcheck => '0',
    gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-92'
  }
}