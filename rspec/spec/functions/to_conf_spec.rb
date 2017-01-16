# rubocop:disable Metrics/LineLength
require 'spec_helper'

describe 'to_conf' do
  it { is_expected.not_to eq(nil) }
  it { is_expected.to run.with_params.and_raise_error(ArgumentError) }
  it { is_expected.to run.with_params('key' => 'value').and_return(/key: value/) }
end
