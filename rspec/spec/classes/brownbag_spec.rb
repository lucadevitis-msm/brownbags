# rubocop:disable Metrics/LineLength
require 'spec_helper'

describe 'brownbag' do
  let(:params) do
    {
      'configuration_file_path' => '/absolute.yml',
      'configuration_file_values' => { 'items' => %w(a b c) }
    }
  end
  it { is_expected.to compile }
  it { is_expected.to contain_class('brownbag::install').that_comes_before('Class[brownbag::config]') }
  it { is_expected.to contain_class('brownbag::config').that_notifies('Class[brownbag::service]') }
  it { is_expected.to contain_class('brownbag::service').that_comes_before('Class[brownbag]') }

  it { is_expected.to contain_file('/usr/bin/brownbag').with_mode('0755') }
  it { is_expected.to contain_brownbag__configuration_file('default') }
  it { is_expected.to contain_file('/etc/init.d/brownbag').with_mode('0755') }
  it { is_expected.to contain_service('brownbag') }
end
