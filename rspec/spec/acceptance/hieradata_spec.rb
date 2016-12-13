require 'acceptance_spec_helper'

describe file('hieradata.yaml') do
  it_behaves_like 'a YAML file'
end
