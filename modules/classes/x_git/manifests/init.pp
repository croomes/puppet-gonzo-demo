class x_git {

  class { 'rpmrepos::rpmforge':
    extras => '1',
  }

  package { 'git':
    ensure  => latest,
    require => Yumrepo['rpmforge-extras'],
  }
}