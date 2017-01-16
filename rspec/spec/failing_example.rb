require 'rspec'

# Let's test the string 'true'. We'd very much like it to evaluate to true!
describe 'true' do
  it { is_expected.to be_truthy }
end

# Let's test the string 'false'. We'd very much like it to evaluate to false!
describe 'false' do
  it { is_expected.to be_falsey }
end
