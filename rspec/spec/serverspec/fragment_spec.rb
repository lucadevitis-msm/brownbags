# rubocop:disable Metrics/LineLength
require 'spec_helper_serverspec'

describe file('fragment.yml') do
  # Use shared example 'a YAML file' which is in spec/support/yaml_file.rb
  it_behaves_like 'a YAML file'

  # You can combine matchers
  its(:fragment_data) { is_expected.to include('meta' => include('schema_version' => '0.2')) }
end
