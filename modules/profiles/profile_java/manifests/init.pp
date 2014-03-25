class profile_java {
  class { 'java':
    distribution => 'jdk',
    version      => 'latest',
  }
}