require 'simplecov'
require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |hook|
  hook.after :suite do
    RSpec::Puppet::Coverage.report! # (95)
    SimpleCov.result.format!
  end
end
