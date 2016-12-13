# I don't want to be bothered with line lenght here.
# rubocop:disable Metrics/LineLength
require 'bin_spec_helper'
require 'brownbag/bin/check_transactions'

describe Brownbag::Bin::CheckTransactions do
  # If not specified, default `subject` would be
  # `Brownbag::Bin::CheckTransactions.new(ARGV)` with `ARGV` being rspec
  # command's `ARGV`.
  #
  # I could create a subject with an argv like the one I would use, but that
  # would just test `Mixlib::CLI` argument parsing methods. Also, I want to
  # show you that with a carfuli/clevar `argv` and `config` usage we can create
  # 100% test friendly check/metrics/scripts.
  subject { Brownbag::Bin::CheckTransactions.new([]) }

  # Given a set of: argv, config, exit status, standard output matching reg exp
  [
    [['spec/fixtures/files/transactions/ok.log'],         {},               0, /OK/],
    [['spec/fixtures/files/transactions/warning.log'],    { warning: 30 },  0, /OK/],
    [['spec/fixtures/files/transactions/warning.log'],    {},               1, /WARNING: 40/],
    [['spec/fixtures/files/transactions/overdraft.log'],  {},               2, /CRITICAL: Not enough money/],
    [['spec/fixtures/files/transactions/broken.log'],     {},               3, /UNKNOWN: fail/],
    [[],                                                  {},               3, /UNKNOWN: transactions log/]
  ].each do |argv, config, exit_status, stdout|
    # I could do it with a shared example, however it has a slightly different
    # meaning.
    context "when argv = #{argv}, config = #{config}" do
      # Override subject's `argv` and `config` attributes
      before(:example) do
        subject.argv = argv
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
