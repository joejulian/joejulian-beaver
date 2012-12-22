class beaver {
  package { "beaver":
    provider => "pip",
    ensure   => installed,
    source   => "git+git://github.com/joejulian/beaver.git",
    require  => [ 
      Package['python-pip'],
      Package['git'],
      Package['ujson'],
      Package['python-argparse'],
      Package['python-pika'],
      Package['python-redis'],
      Package['python-ordereddict'],
      Package['python-daemon'],
    ],
  }

  file { "/etc/init.d/beaver":
    mode   => 755,
    source => "puppet:///modules/beaver/init.d/beaver",
  }

  service { "beaver":
    require   => File[ "/etc/init.d/beaver" ],
    ensure    => running,
    enable    => true,
  }

  ini_setting { "beaver redis_url":
    path    => '/etc/beaver.conf',
    section => 'beaver',
    setting => 'redis_url',
    value   => 'redis://logstash:6379/0',
    ensure  => present,
    notify  => Service['beaver'],
  }

  ini_setting { "beaver redis_namespace":
    path    => '/etc/beaver.conf',
    section => 'beaver',
    setting => 'redis_namespace',
    value   => 'logstash',
    ensure  => present,
    notify  => Service['beaver'],
  }
}
