# Enable and run the brownbag service
class brownbag::service inherits brownbag {
  service { 'brownbag':
    ensure  => running,
    require => File['/etc/init.d/brownbag']
  }
}
