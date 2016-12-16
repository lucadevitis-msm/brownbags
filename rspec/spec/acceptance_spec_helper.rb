require 'beaker-rspec'
require 'beaker-hiera'
require 'serverspec'

# Noteworthy backends:
# - ssh: to execute commands on another host
# - docker: to execute commands inside a running container.
#
# Keep an eye on:
# https://github.com/mizzy/specinfra/tree/master/lib/specinfra/backend
set :backend, :exec

# You can control sudo in many ways.
#
# The following block enables the attribute `:sudo` for each
# example/context. With this you can control sudo like this:
#
# describe command('ls /proc/1'), sudo: false do
#   ...
# end
RSpec.configure do |hook|
  hook.around :each, sudo: false do |example|
    set :disable_sudo, true
    example.run
    set :disable_sudo, false
  end
end

# You can monkey patch available classes, like File, to parse various file
# content types. The following patch is just to make the fragment spec more
# readable.
module Serverspec
  module Type
    class File
      alias fragment_data content_as_yaml
    end
  end
end

# Load all shared examples
Dir['./spec/support/**/*.rb'].each { |shared_example| require shared_example }

# Configure the instance
install_puppet_on :insance, version: '3.7.4',
                            facter_version: '2.4.6',
                            hiera_version: '3.0.6'
RSpec.configure do |hook|
  hook.before :suite do
    on :instance, 'mkdir /opt/brownbag'
    scp_to :instance, '.', '/opt/brownbag'
    install_dev_puppet_module_on :instance, source: '/opt/brownbag',
                                            module_name: 'brownbag'
    wite_hiera_config_on :instance, backends: ['yaml'],
                                    yaml: {datadir: '/etc/puppet/hieradata'},
                                    hierarchy: ['common']
  end
end
