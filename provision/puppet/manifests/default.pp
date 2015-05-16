# -*- mode: puppet-mode -*-
# vi: set ft=ruby :

  # http://www.puppetcookbook.com/posts/set-global-exec-path.html
  Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/", "/usr/local/bin/" ] }

  # create a new run stage to ensure certain modules are included first
  stage { 'pre':
    before => Stage['main']
  }
  
  # # add the baseconfig module to the new 'pre' run stage
  # class { 'known_hosts':
    #   stage => 'pre'
    # }
  
  # add the baseconfig module to the new 'pre' run stage
  class { 'baseconfig':
    stage => 'pre'
  }
  
  node default {

    class { '::emacs':
      username => 'vagrant',
      version  => 'emacs24',
    }

    class { 'python' :
      version    => 'system',
      pip        => true,
      dev        => true,
      virtualenv => true,
      gunicorn   => true,
    }

    class { 'ipython' : }

    Class['python'] -> Class['ipython']
  }



