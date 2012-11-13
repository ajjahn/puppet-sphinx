class { 'sphinx':
  config  => '/var/www/app/etc/sphinx.conf',
  cronjob => false,
}
