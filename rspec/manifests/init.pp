# This class will install, configure and run the brownbag service.
# @author Luca De Vitis <luca.devitis at moneysupermarket.com>
#
# @param conf       [Hash]    The configuration values to set in the file
# @param conf_path  [String]  The configuration file full path
#
# @example brownbag
#   include ::brownbag
class brownbag ($conf      = undef,
                $conf_path = '/etc/brownbag/conf.yml')
{

  # Validate class params
  validate_hash($::brownbag::conf)
  validate_absolute_path($::brownbag::conf_path)

  # Define requirements
  class { '::brownbag::install': } ->
  class { '::brownbag::config': } ~>
  class { '::brownbag::service': } ->
  Class['::brownbag']
}
