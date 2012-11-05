custom_user { 'foo':
  ensure => present,
  groups => ['admin', 'developer'],
  uid => '5033',
}
