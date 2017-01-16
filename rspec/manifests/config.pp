# Install configuration files and init script.
class brownbag::config inherits brownbag {

  # Install the default configuration file
  brownbag::configuration_file { 'default':
    path   => $brownbag::configuration_file_path,
    values => $brownbag::configuration_file_values
  }

  # Install the init script from a template.
  file { '/etc/init.d/brownbag':
    ensure  => file,
    content => template('brownbag/etc/init.d/brownbag'),
    mode    => '0755'
  }
}
