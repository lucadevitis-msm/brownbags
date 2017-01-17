require 'spec_helper_serverspec'

describe file('hieradata.yaml') do
  # Use shared example 'a YAML file' which is in spec/support/yaml_file.rb
  it_behaves_like 'a YAML file'
end
