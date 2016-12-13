require 'rspec'

describe 'true' do
  it { is_expected.to be_truthy }
end
describe 'false' do
  it { is_expected.to be_falsey }
end
