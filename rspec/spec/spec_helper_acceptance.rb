# rubocop:disable Metrics/LineLength
require 'beaker-rspec'
# Configure the instances
RSpec.configure do |hook|
  hook.before :suite do
    hosts.each do |host|
      # If I had had to use a vanilla VirtualBox image, I should have to install
      # ruby/puppet. For this brownbag I'm going to use a custom built centos6,
      # so I don't need to do any of this. Howver, you can always use Beaker
      # DSL to customize instances.
      #
      # on host, 'yum --assumeyes install tar xz zlib-devel openssl-devel'
      # on host, 'yum --assumeyes groupinstall "Development Tools"'
      # on host, 'curl --remote-name http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.gz'
      # on host, 'tar --extract --gzip --file ruby-2.1.5.tar.gz'
      # on host, 'cd ruby-2.1.5 ; ./configure --prefix=/usr ; make ; make install'
      # on host, 'rm --recursive --force ruby-2.1.5'
      # on host, 'curl --remote-name http://production.cf.rubygems.org/rubygems/rubygems-1.8.25.tgz'
      # on host, 'tar --extract --gzip --file rubygems-1.8.25.tgz'
      # on host, 'cd rubygems-1.8.25 ; ruby setup.rb config ; ruby setup.rb setup ; ruby setup.rb install'
      # on host, 'rm --recursive --force "rubygems-1.8.25"'
      # on host, 'gem install puppet --no-rdoc --no-ri --version 3.7.4'
      # on host, 'gem install facter --no-rdoc --no-ri --version 2.4.6'
      # on host, 'gem install hiera  --no-rdoc --no-ri --version 3.0.6'
      # write_hiera_config_on host, backends: ['yaml'],
      #                             yaml: { datadir: '/etc/puppet/hieradata' },
      #                             hierarchy: ['common']
      scp_to host, '.', '/opt/brownbag'
      install_dev_puppet_module_on host, source: '.',
                                         module_name: 'brownbag',
                                         target_module_path: '/etc/puppet/modules'
      on host, 'puppet module install puppetlabs-stdlib'
    end
  end
end
