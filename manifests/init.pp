# == Class: sphinx
#
# Installs and manages Sphinx.
#
# === Parameters
#
# [*config_file*]
#  Sphinx configuration file or template.
#
# [*cronjob*]
#  Run indexer nightly. Default: true
#
# === Examples
#
# class { 'sphinx':
#   config_file => 'sphinx/sphinx.conf.erb',
#   cronjob     => false,
# }
#
# === Authors
#
# Sergey Stankevich
#
class sphinx (
  $config_file = false,
  $cronjob     = true,
) {

  # Compatibility check
  $compatible = [ 'Debian', 'Ubuntu' ]
  if ! ($::operatingsystem in $compatible) {
    fail("Module is not compatible with ${::operatingsystem}")
  }

  Class['sphinx::install'] -> Class['sphinx::config']

  include sphinx::install
  include sphinx::config

}
