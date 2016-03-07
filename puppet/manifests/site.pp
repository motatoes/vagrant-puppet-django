# == Ensures that the user $user exists == #

package { ["libpq-dev","postgresql","postgresql-contrib"]:
    ensure => latest,
    install_options => ["--allow-unauthenticated", "-f"],
}


# == add $user to the sudoers == #

class { "sudo": }


user { "${username}": 
  ensure    => present,
  shell     => "/bin/bash",
  home      => "/home/${username}",
  password  => "${password}",
  groups    => ["admin"],
}
 
# == vagrant user needs to be a sudoer == #

sudo::conf {"vagrant":
  ensure => present,
  content => "vagrant ALL=(ALL) NOPASSWD:ALL",
}

sudo::conf { "admins":
  ensure => present,
  content => "%admin ALL=(ALL) ALL",
}

# == Ensure that some directories exist == #

# Ensures that the $user home directory exits
file { "/home/${username}":
  ensure => "directory",
  owner => "${username}"
}

file { "/home/${username}/virtualenvs":
  ensure => "directory",
  owner => "${username}"
}

file { "/home/${username}/${projectname}":
  ensure => "directory",
  owner => "${username}"
}

class { "postgresql::server": }

postgresql::server::db { "${projectname}":
    user => "${username}",
    password => "${username}"
}


class { "python": 
    version     => "system",
    pip         => true,
    dev         => true,
    virtualenv  => true,
}

python::virtualenv { "/home/${username}/virtualenvs/${projectname}":
     ensure     => present,
     version    => "system",
     systempkgs => true,
     distribute => false,
     venv_dir   => "/home/${username}/virtualenvs/${projectname}",
     owner      => "${username}",
}

python::pip { "django":
    pkgname => "django",
    ensure => "1.8",
    virtualenv => "/home/${username}/virtualenvs/${projectname}"
}

# install psycopg2 to use postgresql database with django
python::pip { "psycopg2":
   pkgname => "psycopg2",
   ensure => latest,
   virtualenv => "/home/${username}/virtualenvs/${projectname}",
}


