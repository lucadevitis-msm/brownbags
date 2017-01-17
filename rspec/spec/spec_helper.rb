require 'simplecov'
require 'puppetlabs_spec_helper/module_spec_helper'

# When can configure `simplecov` to compute the code coverage of our tests.
RSpec.configure do |hook|
  hook.after :suite do
    # This reports the puppet catalogue coverage. It fails if coverage < 100%
    # because, seriously, we can alway do it.
    RSpec::Puppet::Coverage.report! # (95)
    # This reports the ruby code coverage.
    SimpleCov.result.format!
  end
end
