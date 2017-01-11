# rubocop:disable Metrics/LineLength
# require 'serverspec'
require 'beaker-rspec'

# Noteworthy backends:
# - ssh: to execute commands on another host
# - docker: to execute commands inside a running container.
#
# Keep an eye on:
# https://github.com/mizzy/specinfra/tree/master/lib/specinfra/backend
# set :backend, :exec

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

# def install_epel_on(host)
#   on host, 'wget --progress=dot:mega http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm'
#   on host, 'rpm -ivh epel-release-7-8.noarch.rpm'
# end

# Configure the instances
RSpec.configure do |hook|
  hook.before :suite do
    hosts.each do |host|
      # Not portable, but I know we are always talking about redhat
      # on host, 'yum --assumeyes install tar xz zlib-devel openssl-devel'
      # on host, 'yum --assumeyes groupinstall "Development Tools"'
      # on host, 'curl --remote-name http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.gz'
      # on host, 'tar --extract --verbose --gzip --file ruby-2.1.5.tar.gz'
      # on host, 'cd ruby-2.1.5 ; ./configure --prefix=/usr ; make ; make install'
      # on host, 'rm --recursive --force ruby-2.1.5'
      # on host, 'curl --remote-name http://production.cf.rubygems.org/rubygems/rubygems-1.8.25.tgz'
      # on host, 'tar --extract --verbose --gzip --file rubygems-1.8.25.tgz'
      # on host, 'cd rubygems-1.8.25 ; ruby setup.rb config ; ruby setup.rb setup ; ruby setup.rb install'
      # on host, 'rm --recursive --force "rubygems-1.8.25"'
      # on host, 'gem install puppet --no-rdoc --no-ri --version 3.7.4'
      # on host, 'gem install facter --no-rdoc --no-ri --version 2.4.6'
      # on host, 'gem install hiera  --no-rdoc --no-ri --version 3.0.6'
      # scp_to host, '.', '/opt/brownbag'
      # install_dev_puppet_module_on host, source: '.',
      #                                    module_name: 'brownbag'
      # write_hiera_config_on host, backends: ['yaml'],
      #                             yaml: { datadir: '/etc/puppet/hieradata' },
      #                             hierarchy: ['common']
    end
  end
end