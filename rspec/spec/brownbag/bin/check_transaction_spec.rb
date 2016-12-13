# I don't want to be bothered with line lenght here.
# rubocop:disable Metrics/LineLength
require 'bin_spec_helper'
require 'brownbag/bin/check_transactions'

describe Brownbag::Bin::CheckTransactions do
  # Given a set of: argv, exit status, standard output matching reg exp
  [
    [%w(spec/fixtures/files/transactions/ok.log), 0, /OK/],
    [%w(-w 30 spec/fixtures/files/transactions/warning.log), 0, /OK/],
    [%w(spec/fixtures/files/transactions/warning.log), 1, /WARNING: 40/],
    [%w(spec/fixtures/files/transactions/overdraft.log), 2, /CRITICAL: Not enough money/],
    [%w(spec/fixtures/files/transactions/broken.log), 3, /UNKNOWN: fail/],
    [[], 3, /UNKNOWN: transactions log/]
  ].each do |argv, exit_status, stdout|
    # I could do it with a shared example, however it has a slightly different
    # meaning.
    context "when run with #{argv.join(' ')}" do
      subject { Brownbag::Bin::CheckTransactions.new(argv) }

      it "should exit with status #{exit_status} and output matching #{stdout.inspect}" do
        exit_ = raise_error(SystemExit) { |e| expect(e.status).to eq exit_status }
        output_ = output(stdout).to_stdout
        expect { subject.run }.to output_ & exit_
      end
    end
  end
end
