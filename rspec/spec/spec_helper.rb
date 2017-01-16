require 'puppetlabs_spec_helper/module_spec_helper'
require 'simplecov'

SimpleCov.at_exit do
  puts 'Code coverage:'
  SimpleCov.result.format!
  puts "\nResource coverage:"
  RSpec::Puppet::Coverage.report! # (95)
end
