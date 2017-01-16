SimpleCov.start do
  minimum_coverage 100
  minimum_coverage_by_file 100
  refuse_coverage_drop
  formatter = SimpleCov::Formatter::HTMLFormatter
  add_filter '/spec/'
  add_filter '/.vendor/'
end
