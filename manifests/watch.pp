define beaver::watch(
  $target = $name,
  $debug  = undef,
  $discover_interval = 15,
  $exclude = undef,
  $format  = undef,
  $message_format = undef,
  $sincedb_path = undef,         # not implemented in beaver
  $sincedb_write_interval = 15,  #
  $stat_interval = 1,
  $tags = undef,
  $type,
  $ensure = present
) {
  if $debug {
    ini_setting { "$name - debug":
      path    => "/etc/beaver.conf",
      section => $target,
      setting => "debug",
      value   => "true",
      ensure  => $ensure,
    }
  }
  if $exclude{
    ini_setting { "$name - exclude":
      path    => "/etc/beaver.conf",
      section => $target,
      setting => "exclude",
      value   => $exclude,
      ensure  => $ensure,
    }
  }
  if $format{
    ini_setting { "$name - format":
      path    => "/etc/beaver.conf",
      section => $target,
      setting => "format",
      value   => $format,
      ensure  => $ensure,
    }
  }
  if $message_format{
    ini_setting { "$name - message_format":
      path    => "/etc/beaver.conf",
      section => $target,
      setting => "message_format",
      value   => $message_format,
      ensure  => $ensure,
    }
  }
  if $tags{
    ini_setting { "$name - tags":
      path    => "/etc/beaver.conf",
      section => $target,
      setting => "tags",
      value   => $tags,
      ensure  => $ensure,
    }
  }

  ini_setting { "$name - discover_interval":
    path    => "/etc/beaver.conf",
    section => $target,
    setting => 'discover_interval',
    value   => $discover_interval,
    ensure  => $ensure
  }
  ini_setting { "$name - stat_interval":
    path    => "/etc/beaver.conf",
    section => $target,
    setting => 'stat_interval',
    value   => $stat_interval,
    ensure  => $ensure
  }
  ini_setting { "$name - type":
    path    => "/etc/beaver.conf",
    section => $target,
    setting => 'type',
    value   => $type,
    ensure  => $ensure
  }
}
