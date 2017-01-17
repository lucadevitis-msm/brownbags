require 'spec_helper_acceptance'

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
  describe file('/etc/redhat-release') do
    it { is_expected.to be_file }
    its(:content) { is_expected.to include('CentOS release 6') }
  end

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

  # This is a regression test I inserted after I found out that `be_reachable`
  # implementation in Specinfra tend to use `nc` command most of the times, but
  # `nc` is not installed by default.`
  # Supports multiple package managers.
  describe package('nc') do
    it { is_expected.to be_installed.by(:rpm).with_version('1.84') }
  end

  # Test the outcome of specific commands
  describe command('netstat') do
    its(:exit_status) { is_expected.to eq 0 }
  end

  # You can inspect running processes in great detail. For the purpose of this
  # brownbag we'll take advantage of the sshd that Beaker will spin up.
  # Remember, Serverspec/Specinfra can run commands directly into the container
  # using a Docker command dispatcher. However, `beaker-rspec` defines and uses
  # a Beaker specific command dispatcher that sits on top of the
  # Serverspec/Specinfra ssh one. For semplicity, Beaker spins up sshd on any
  # kind of instance so it can use the same approach regardles of the instance
  # type.
  sshd_pidfile = '/var/run/sshd.pid'
  describe file(sshd_pidfile) do
    it { is_expected.to exist }
    it { is_expected.to be_file }
    its(:size) { is_expected.to be > 0 }
    its(:content) { is_expected.to match(/^[0-9]+$/) }
  end
  # Test any attribute that you can get from `ps` command
  describe process('sshd') do
    its(:pid) { is_expected.to eq command("cat #{sshd_pidfile}").stdout.to_i }
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
