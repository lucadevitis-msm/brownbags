# This class will install, configure and run the brownbag service.
# @author Luca De Vitis <luca.devitis at moneysupermarket.com>
#
# @param configuration_file_values  [Hash]    The configuration values
# @param configuration_file_path    [String]  The configuration file full path
#
# @example brownbag
#   include ::brownbag
class brownbag ($configuration_file_values = undef,
                $configuration_file_path   = '/etc/brownbag/conf.yml')
{

  # Validate class params
  validate_hash($::brownbag::configuration_file_values)
  validate_absolute_path($::brownbag::configuration_file_path)

  # Set up class-wide defaults
  Exec {
    path => ['/bin']
  }

  # Define requirements
  class { '::brownbag::install': } ->
  class { '::brownbag::config': } ~>
  class { '::brownbag::service': } ->
  Class['::brownbag']
}
