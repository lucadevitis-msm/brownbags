require 'spec_helper_serverspec'

# RSpec interface to `docker inspect`
describe docker_image('centos:6.6') do
  it { is_expected.to exist }

  # Use `its(:inspection)` to access `subject.inspection` which is the output
  # of `docker inspect`
  its(:inspection) do
    is_expected.to include('Architecture' => 'amd64', 'Os' => 'linux')
  end
end

# We can also inspect a running container
describe docker_container('brownbag') do
  it { is_expected.to exist }
  it { is_expected.to be_running }
  it { is_expected.not_to have_volume('/tmp', '/data') }

  # Use lists as argument for `its` to make use the `[]` operator of `subject`
  # in order to access `inspection` data.
  its(['HostConfig.NetworkMode']) { is_expected.to match(/bridge|default/) }
  its(['Config.Image']) { is_expected.to eq 'centos:6.6' }
end
