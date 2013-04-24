class beaver (
  $init_path       = "/etc/init.d/beaver",
  $service_name    = "beaver",
  $ini_path        = "/etc/beaver.conf",
  $redis_url       = "redis://logstash:6379/0",
  $redis_namespace = "logstash"
) {
  include packages::beaver

  file { $init_path:
    mode   => 755,
    source => "puppet:///modules/beaver/init.d/beaver",
  }

  file { '/etc/sysconfig/beaver':
    mode => '0755',
    content => 'BEAVER_OPTIONS="-t redis"',
  }

  service { $service_name:
    require   => File[ $init_path ],
    ensure    => running,
    enable    => true,
  }

  ini_setting { "beaver redis_url":
    path    => $ini_path,
    section => 'beaver',
    setting => 'redis_url',
    value   => $redis_url,
    ensure  => present,
    notify  => Service[$service_name],
  }

  ini_setting { "beaver redis_namespace":
    path    => $ini_path,
    section => 'beaver',
    setting => 'redis_namespace',
    value   => $redis_namespace,
    ensure  => present,
    notify  => Service[$service_name],
  }
}
