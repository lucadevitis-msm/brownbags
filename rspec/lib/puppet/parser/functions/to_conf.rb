# rubocop:disable Style/ClosingParenthesisIndentation
# I'd like these puppet parser functions to be the exception when it comes to
# parenthesis indentation.
require 'yaml'

# Returns brownbag configuration file content as a YAML document
# @author Luca De Vitis <luca.devitis at moneysupermarket.com>

Puppet::Parser::Functions.newfunction(:to_conf, type: :rvalue, doc: <<-'DOC'
  Turn the argument into brownbag configuration.

  Usage:

  # /path/to/file.yml content is expected to be valid YAML:
  # ---
  # key4:
  #   sub2: again
  #   sub1: another
  # key3: 1
  # key2:
  #   - an
  #   - array
  # key1: string

  $content = {
    'key1' => 'string',
    'key2' => ['an', 'array'],
    'key3' => 1,
    'key4' => {
      'sub1' => 'another',
      'sub2' => 'again'
    }
  }

  file { '/path/to/file.yml':
    ensure  => file,
    content => to_conf($content)
  }
  DOC
) do |args|
  # @return [String] something
  raise ArgumentError if args.empty?
  YAML.dump(args.first)
end
