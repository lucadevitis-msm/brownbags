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
RSpec.configure do |c|
  c.around :each, sudo: false do |example|
    set :disable_sudo, true
    example.run
    set :disable_sudo, false
  end
end
