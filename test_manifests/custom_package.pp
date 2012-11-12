#custom_package { 'apache': }

#custom_package { 'apache':
#  name => 'httpd',
#}

#custom_package { 'apache':
#  version => '2.2.22-1ubuntu1',
#}

#custom_package { 'apache':
#  ensure => present,
#}

#custom_package { 'apache':
#  ensure => present,
#  source => 'http://package_repo/apache.rpm',
#}

#Custom_package {
#  ensure => present,
#}
#custom_package { ['package_one', 'package_two']: }

#file { '/tmp/apache.deb':
#  ensure => absent,
#  require => Custom_package['apache'],
#}
#custom_package { 'apache':
#  ensure => present,
#  source => '/tmp/apache.deb',
#}

#custom_package { 'apache':
#  name           => 'apache2',
#  ensure         => present,
#  version        => '2.2.22-1ubuntu1',
#  source         => '/tmp/foo.deb',
#  replace_config => yes,
#}

custom_package { 'httpd':
    ensure => present,
#  provider => gems
#  ensure  => present,
#  version => '1.2.3-5',
}
