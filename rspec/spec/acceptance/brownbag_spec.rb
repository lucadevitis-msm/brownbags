require 'spec_helper_acceptance'

describe 'brownbag class' do
  let(:pp) do
    <<-EOS
      class { 'brownbag':
        configuration_file_path   => '/etc/brownbag.conf',
        configuration_file_values => {
          key1 => 'value1',
          key2 => 'value2'
        }
      }
    EOS
  end

  # `catch_failures: true` runs puppet with --detailed-exitcodes, so we
  # expect first run `exit_code` to be 2 and second to be 0
  describe 'puppet apply manifest' do
    subject { apply_manifest pp, catch_failures: true }

    it 'should run without errors' do
      expect(subject.exit_code).to eq 2
    end

    it 'should run a second time without changes' do
      expect(subject.exit_code).to eq 0
    end
  end

  # The main and the init scripts should be installed.
  # Considering the triviality of the brownbag puppet module, these are
  # basically accessory examples, however they are important: their purpose is
  # to give me more feedback if something goes wrong with the spec.
  describe file('/usr/bin/brownbag') do
    it { is_expected.to be_file }
    it { is_expected.to be_executable }
  end
  describe file('/etc/init.d/brownbag') do
    it { is_expected.to be_file }
    it { is_expected.to be_executable }
    its(:content) do
      is_expected.to match(%r{^config="/etc/brownbag\.conf"$})
    end
  end

  # Let's see if `brownbag::configuration_file` generates a valid configuration
  describe file('/etc/brownbag.conf') do
    it { is_expected.to be_file }
    its(:content_as_yaml) do
      is_expected.to include('key1' => 'value1', 'key2' => 'value2')
    end
  end

  # The main spec check
  describe service('brownbag') do
    it { is_expected.to be_running }
  end
end
