# rubocop:disable Style/Documentation
require 'yaml'

module Puppet
  module Parser
    module Functions
      newfunction(:to_conf, type: :rvalue, doc: <<-'ENDHEREDOC'
                   Turn the argument into brownbag configuration.

                   Usage:

                   $content = {
                     'key1' => 'string',
                     'key2' => ['an', 'array'],
                     'key3' => 1,
                     'key4' => {
                       'sub1' => 'another',
                       'sub2' => 'again'
                     }
                   }

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

                   file { '/path/to/file.yml':
                     ensure  => file,
                     content => to_conf($content)
                   }
                   ENDHEREDOC
                 ) do |args|
        return YAML.dump(args.first)
      end
    end
  end
end
