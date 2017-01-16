# rubocop:disable Metrics/LineLength
# rubocop:disable Style/HashSyntax
require 'spec_helper'

describe 'brownbag::configuration_file' do
  let(:configuration_file_path) { '/some/path.yml' }
  let(:configuration_file_values) { { 'key' => 'value' } }
  let(:title) { 'default' }
  let(:params) { { :path => configuration_file_path, :values => configuration_file_values } }

  # I'm not going to test the file content here, because it depends on the
  # `to_conf` function and I already have a spec for that.
  it { is_expected.to contain_file("#{title}_conf_path").with_path(configuration_file_path) }

  context 'when $values is undef' do
    let(:params) { { :path => configuration_file_path, :values => :undef } }

    it { is_expected.to contain_exec("#{title}_conf_path").with_command(/^touch/) }
  end

  context 'when $path is undef' do
    let(:params) { { :path => :undef, :values => configuration_file_values } }

    it { is_expected.to contain_file("#{title}_conf_path").with_path(title) }
  end
end
