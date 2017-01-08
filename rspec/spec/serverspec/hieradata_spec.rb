require 'spec_helper_serverspec'

describe file('hieradata.yaml') do
  it_behaves_like 'a YAML file'
end
