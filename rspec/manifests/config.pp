# Install configuration files and init script.
class brownbag::config inherits brownbag {
  # `undef` is incredibly usefull: we should use more of it.
  if $::brownbag::conf == undef
  {
    # On the other hand, we abuse of `Exec` resources. Seriously.
    # Note that I've used a custom resource `title`, rather then using the
    # command itself. It makes the resource "test friendly".
    exec { 'conf_path':
      command => "/bin/touch ${::brownbag::conf_path}",
      creates => $::brownbag::conf_path
    }
  } else {
    file { 'conf_path':
      ensure  => file,
      path    => $::brownbag::conf_path,
      content => to_conf($::brownbag::conf)
    }
  }

  # Install the init script from a template.
  file { '/etc/init.d/brownbag':
    ensure  => file,
    content => tempalte('modules/brownbag/etc/init.d/brownbag'),
    mode    => '0755',
    require => File['/usr/bin/brownbag']
  }
}
