class profile_bamboo {
  class { 'java':
    distribution => 'jdk',
    version      => 'latest',
  }

  include x_git
  include x_bamboo
}