# == Class: bro
#
# Full description of class bro here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { bro:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class bro (
	$basedir      = $bro::params::basedir,
	$sitedir      = $bro::params::sitedir,
	) inherits bro::params {

#	$localbro_custom = "puppet:///modules/bro/localbro/${::hostname}_local.bro"

  $localbro_default = "puppet:///modules/bro/localbro/$sitepolicy"
#  $localbro_custom = "puppet:///modules/bro/localbro/${::hostname}_local.bro"
#  $localbro_custom = "puppet:///modules/bro/localbro/custom_local.bro"

  file { "$sitedir/$sitepolicy":
#    source => [ "$localbro_custom","$localbro_default" ],
    source =>  "$localbro_default",
    notify => Service['wassup_bro'],
  }


  file { "$basedir/bin/wassup_bro":
    mode => '0755',
    content => template('bro/wassup_bro.erb'),
  }


  file { 'scripts':
    name      => "$basedir/share/bro/my_scripts",
    recurse   => true,
    purge     => true,
    force     => true,
    source    => "puppet:///modules/bro/scripts",
    ignore    => '.git',
    notify    => Service['wassup_bro'],
#   require   => Exec['create_site_dir'],
#    show_diff => false,
  }

  service { 'wassup_bro':
    ensure  => $bro_state,
    status  => $status,
    start   => $start,
    restart => $restart,
    stop    => $stop,
    path    => "$basedir/bin/",
    require => File["$basedir/bin/wassup_bro"],
  }



}
