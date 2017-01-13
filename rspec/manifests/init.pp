class brownbag ($conf      = undef,
                $conf_path = '/etc/brownbag/conf.yml')
{

  $conf_resource = $::brownbag::conf ? {
    undef   => Exec['conf_path'],
    default => File['conf_path']
  }

  if $::brownbag::conf == undef
  {
    exec { 'conf_path':
      command => "/bin/echo '---' > ${::brownbag::conf_path}",
      creates => $::brownbag::conf_path
    }
  } else {
    file { 'conf_path':
      ensure  => file,
      path    => $::brownbag::conf_path,
      content => to_brownbag($::brownbag::conf)
    }
  }

  file { '/usr/bin/brownbag':
    ensure  => file,
    source  => 'puppet:///modules/brownbag/usr/bin/brownbag',
    mode    => '0755',
    require => $conf_resource
  }

  file { '/etc/init.d/brownbag':
    ensure  => file,
    content => tempalte('modules/brownbag/etc/init.d/brownbag'),
    mode    => '0755',
    require => File['/usr/bin/brownbag']
  }

  service { 'brownbag':
    ensure  => running,
    require => File['/etc/init.d/brownbag']
  }
}
