class profile_gonzo::server {

  include x_git
  # include x_postgres::devel
  # include mccouchdb
  include rvm

  if $rvm_installed == "true" {

    rvm_system_ruby { 'ruby-2.1.0':
      ensure      => 'present',
      default_use => true,
      build_opts  => ['--autolibs=install-packages'];
    }

    rvm_gemset { 'ruby-2.1.0@gonzo':
      ensure  => present,
      require => Rvm_system_ruby['ruby-2.1.0'];
    }

    rvm_gem {
      'ruby-2.1.0@gonzo/bundler':
        ensure  => '1.5.3',
        require => Rvm_gemset['ruby-2.1.0@gonzo'];
    }

  }

  include gonzo::server
}