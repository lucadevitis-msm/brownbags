require 'acceptance_spec_helper'

# Other very interesting things you can include in your spec:
# - users
# - groups
# - files
#   - content inspection included
#   - including certificates
# - windows registry and features
# - containers and images (lxc and docker)
# - yum repos
describe host('localhost') do
  it { is_expected.to be_resolvable.by('hosts') }

  # You can filter out some checks
  describe interface('lo'), if: os[:family] == 'redhat' do
    its(:ipv4_address) { is_expected.to eq '127.0.0.1/8' }
  end

  # Test remote connections
  describe host('www.google.com') do
    it { is_expected.to be_resolvable.by('dns') }
    it { is_expected.to be_reachable.with(port: 80, proto: 'tcp', timeout: 5) }
  end

  # Supports multiple package managers
  describe package('ruby') do
    it { is_expected.to be_installed.by(:rpm).with_version('1.8.7') }
  end

  # Test the outcome of specific commands
  describe command('netstat') do
    its(:exit_status) { is_expected.to eq 0 }
  end

  # Test any attribute that you can get from `ps` command
  describe process('init') do
    its(:pid) { is_expected.to eq 1 }
    its(:user) { is_expected.to eq 'root' }
  end

  describe port(22) do
    it { is_expected.to be_listening.on('0.0.0.0').with('tcp') }
  end

  # you can also check if it is running under a specific manager like systemd
  # or supervisor or checked buy a monitoring system (few are supported)
  describe service('sshd') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end
end
