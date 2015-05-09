# -*- mode: puppet-mode -*-
# vi: set ft=ruby :


# install emacs from pre-compiled source
# modeled from here : https://github.com/finitud/vagrant-common-lisp/blob/master/private/puppet/manifests/base.pp

class emacs( $version = 'emacs24', $username = 'emacs' ) {
  $group = $username
    
  notice( "running emacs install under user: $username..." )

  if !defined(Package['curl']) {
    package{'curl':
      ensure => present,
    }
  }

  # apt::source { 'debian_unstable':
  #   comment  => 'This is the iWeb Debian unstable mirror',
  #   location => 'http://debian.mirror.iweb.ca/debian/',
  #   release  => 'unstable',
  #   repos    => 'main contrib non-free',
  #   pin      => '-10',
  #   key      => {
  #     'id'     => 'A1BD8E9D78F7FE5C3E65D8AF8B48AD6246925553',
  #     'server' => 'subkeys.pgp.net',
  #   },
  #   include  => {
  #     'src' => true,
  #     'deb' => true,
  #   },
  # }
  
  # # magit mode in emacs depends on makeinfo, so need texinfo pkg
  # ## http://www.linuxfromscratch.org/lfs/view/stable/chapter05/texinfo.html
  # if !defined(Package['texinfo']) {
  #   package{'texinfo':
  #     ensure => present,
  #   }
  # }

  # distel mode in emacs depends on texlive
  if !defined(Package['texlive']) {
    package{'texlive':
      ensure => present,
    }
  }

  # el-get needs bzr to install python-mode
  if !defined(Package['bzr']) {
    package{'bzr':
      ensure => present,
    }
  }

  exec { 'initial update':
    command => '/usr/bin/apt-get -y update',
    path    => "/sbin:/usr/bin:/usr/local/bin/:/bin/",
  }
  
  package{ ['python-software-properties']:
    ensure => present,
    require => Exec[ 'initial update' ],
  }

  # package{ ['curl', 'python-software-properties']:
  #   ensure => present,
  #   require => Exec[ 'initial update' ],
  # }

  exec { 'add emacs repository':
    command => 'add-apt-repository ppa:cassou/emacs -y',
    path    => "/sbin:/usr/bin:/usr/local/bin/:/bin/",
    require => Package[ 'python-software-properties' ],
  }
  
  exec { 'second update':
    command => 'apt-get -y update',
    path    => "/sbin:/usr/bin:/usr/local/bin/:/bin/",
    require => Exec[ 'add emacs repository' ],
  }
  
  # package{ [ 'emacs24', 'emacs24-el', 'emacs24-common-non-dfsg', 'git-core', 'sbcl', 'sbcl-doc', 'sbcl-source', ]:
  #   ensure => present,
  #   require => Exec[ 'second update' ],
  # }

  package{ [ 'emacs24', 'emacs24-el', 'emacs24-common-non-dfsg', 'sbcl', 'sbcl-doc', 'sbcl-source', ]:
    ensure => present,
    require => Exec[ 'second update' ],
  }

  vcsrepo{ "/home/$username/.emacs.d":
    ensure => latest,
    provider => git,
    source => 'https://github.com/RomanShestakov/.emacs.d',
    revision => 'master',
    user => $username
  }
}
