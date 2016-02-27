# Ensures that the user coupmonitor exists

package { ['libpq-dev','postgresql','postgresql-contrib']:
    ensure => latest,
    install_options => ['--allow-unauthenticated', '-f'],
}


# add coupmonitor to the sudoers

class { 'sudo': }


user { 'coupmonitor':
  ensure    => present,
  shell     => '/bin/bash',
  home      => '/home/coupmonitor',
  password  => '$1$bi5lnZpn$Q.g2suQsXsdej2bJMj1p50',
  groups    => ['admin'],
}
 
#vagrant user needs to be a sudoer
sudo::conf {'vagrant':
  ensure => present,
  content => 'vagrant ALL=(ALL) NOPASSWD:ALL',
}

sudo::conf { 'admins':
  ensure => present,
  content => '%admin ALL=(ALL) ALL',
}

## Ensure that some directories exist
# Ensures that the coupmonitor home directory exits
file { '/home/coupmonitor':
  ensure => 'directory',
  owner => 'coupmonitor'
}

file { '/home/coupmonitor/virtualenvs':
  ensure => 'directory',
  owner => 'coupmonitor'
}

file { '/home/coupmonitor/coupmonitor_main':
  ensure => 'directory',
  owner => 'coupmonitor'
}

## Configuration for some scripts
# ensures that apache is installed on the machine
class { 'apache': }

apache::vhost { 'coupmonitor.com':
    port     => '80',
    docroot  => '/home/coupmonitor/CM_main' 
}

class { 'postgresql::server': }

postgresql::server::db { 'coupmonitor_main':
    user => 'coupmonitor',
    password => 'coupmonitor'
}


class { 'python': 
    version     => 'system',
    pip         => true,
    dev         => true,
    virtualenv  => true,
}

python::virtualenv { '/home/coupmonitor/coupmonitor_main':
     ensure     => present,
     version    => 'system',
     systempkgs => true,
     distribute => false,
     venv_dir   => '/home/coupmonitor/virtualenvs/coupmonitor_main',
     owner      => 'coupmonitor',
}

python::pip { 'django':
    pkgname => 'django',
    ensure => '1.8',
    virtualenv => '/home/coupmonitor/virtualenvs/coupmonitor_main'
}

# install psycopg2 to use postgresql database with django
python::pip { 'psycopg2':
   pkgname => 'psycopg2',
   ensure => latest,
   virtualenv => '/home/coupmonitor/virtualenvs/coupmonitor_main',
}


