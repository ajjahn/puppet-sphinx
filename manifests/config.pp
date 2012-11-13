class sphinx::config {

  Exec['sphinx_enable'] -> File['/etc/sphinxsearch/sphinx.conf'] -> Service['sphinxsearch']
  File['/etc/sphinxsearch/sphinx.conf'] ~> Service['sphinxsearch']

  exec { 'sphinx_enable':
    command => 'sed -i "s/START=no/START=yes/g" /etc/default/sphinxsearch',
    unless  => 'grep -q "START=yes" /etc/default/sphinxsearch',
  }

  file { '/etc/sphinxsearch/sphinx.conf':
    ensure => link,
    target => $sphinx::config_file,
  }

  service { 'sphinxsearch':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }

  if $sphinx::cronjob {
    cron { 'sphinx_indexer':
      ensure  => present,
      command => 'indexer --all --rotate > /dev/null',
      user    => 'root',
      hour    => '5',
      minute  => '0',
    }
  }

}
