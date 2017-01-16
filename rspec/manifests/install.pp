# Install the brownbag service.
class brownbag::install inherits brownbag {
  # With rare exceptions, you definitely do not want to have a real piece of
  # code in a puppet module: it tightly couples the software with the module.
  file { '/usr/bin/brownbag':
    ensure => file,
    source => 'puppet:///modules/brownbag/usr/bin/brownbag',
    mode   => '0755'
  }
}
