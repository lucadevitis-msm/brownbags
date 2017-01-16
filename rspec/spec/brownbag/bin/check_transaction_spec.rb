# I don't want to be bothered with line lenght here.
# rubocop:disable Metrics/LineLength
require 'spec_helper'
require 'spec_helper_bin'
require 'brownbag_rspec/bin/check_transactions'

describe BrownbagRspec::Bin::CheckTransactions do
  # `config` is always empty for this spec, but I want to show you that with a
  # carfull/clevar `argv` and `config` usage we can create 100% test friendly
  # check/metrics/scripts.
  #
  # If not specified, default `subject` would be
  # `Brownbag::Bin::CheckTransactions.new(ARGV)` with `ARGV` being rspec
  # command's `ARGV`.
  #
  # Given a set of: argv, config, exit status, standard output matching reg exp
  [
    [%w(spec/fixtures/files/transactions/ok.log),                   {},  0, /OK/],
    [%w(--warning 30 spec/fixtures/files/transactions/warning.log), {},  0, /OK/],
    [%w(spec/fixtures/files/transactions/warning.log),              {},  1, /WARNING: 40/],
    [%w(spec/fixtures/files/transactions/overdraft.log),            {},  2, /CRITICAL: Not enough money/],
    [%w(spec/fixtures/files/transactions/broken.log),               {},  3, /UNKNOWN: fail/],
    [[],                                                            {},  3, /UNKNOWN: transactions log/]
  ].each do |argv, config, exit_status, stdout|
    # I could do it with a shared example, however it has a slightly different
    # meaning.
    context "when argv = #{argv}, config = #{config}" do
      subject { BrownbagRspec::Bin::CheckTransactions.new(argv) }

      # Override subject's `config` attribute
      before(:example) do
        subject.config.update(config)
      end
      it "should exit with status #{exit_status} and output matching #{stdout.inspect}" do
        exit_ = raise_error(SystemExit) { |e| expect(e.status).to eq exit_status }
        output_ = output(stdout).to_stdout
        expect { subject.run }.to output_ & exit_
      end
    end
  end
end
