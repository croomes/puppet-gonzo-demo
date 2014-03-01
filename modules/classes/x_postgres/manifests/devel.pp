class x_postgres::devel (
    $package = 'postgresql92-devel',
  ) {

  include x_postgres

  # Unfortunately this will pull in the server too, not just
  # the headers.
  package { $package: 
    ensure => installed,
    require => Yumrepo['pgdg92'],
  }

  file { '/usr/bin/pg_config': 
    ensure => link,
    target => '/usr/pgsql-9.2/bin/pg_config'
  }
}