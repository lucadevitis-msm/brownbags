# rubocop:disable Metrics/LineLength
require 'spec_helper'
require 'spec_helper_serverspec'

describe file('fragment.yml') do
  it_behaves_like 'a YAML file'

  # You can combine matchers
  its(:fragment_data) { is_expected.to include('meta' => include('schema_version' => '0.2')) }
end
