# This defined type will create the brownbag configuration file.
# If `values` is `undef`, an empty file will be created.
# @author Luca De Vitis <luca.devitis at moneysupermarket.com>
#
# @param values  [Hash]    The configuration values
# @param path    [String]  The configuration file full path
#
# @example brownbag
#   include ::brownbag
define brownbag::configuration_file ($path = $title, $values = undef)
{
  # `undef` is incredibly usefull: we should use more of it.
  if $values == undef
  {
    # On the other hand, we abuse of `Exec` resources. Seriously.
    # Note that I've used a custom resource `title`, rather then using the
    # command itself: it makes the resource "test friendly".
    exec { "${title}_conf_path":
      command => "touch ${path}",
      creates => $path
    }
  } else {
    file { "${title}_conf_path":
      ensure  => file,
      path    => $path,
      content => to_conf($values)
    }
  }
}
