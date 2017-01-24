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
# rubocop:disable Style/Documentation
module Serverspec
  module Type
    class File
      alias fragment_data content_as_yaml
    end
  end
end
# rubocop:enable Style/Documentation

# Load all shared examples
Dir['./spec/support/**/*.rb'].each { |shared_example| require shared_example }
