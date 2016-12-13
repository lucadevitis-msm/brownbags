require 'sensu-plugin/check/cli'
require 'brownbag/account'

module Brownbag
  module Bin
    # Check an account transactions log against a threshold
    # @author Luca De Vitis <luca.devitis at moneysupermarket.com>
    class CheckTransactions < Sensu::Plugin::Check::CLI
      option :warning,
             description: 'balance warning threshold',
             short: '-w threshold',
             long: '--warning threshold',
             default: 50,
             proc: proc { |a| a.to_i }

      # Truth is... this looks suspiciously like a spec...
      def run
        transactions_log = argv[0]

        unknown 'transactions log' unless transactions_log

        account = Brownbag::Account.new

        # I'm expecting each log to be like: `operation amount`
        File.read(transactions_log).lines.each do |log|
          operation, amount = log.split
          unknown operation unless %w(deposit withdrow).include? operation
          unknown amount unless amount =~ /^[0-9]+/
          account.send operation.to_sym, amount.to_i
        end

        warning account.balance if account.balance < config[:warning]
        ok

      rescue => error
        critical error.message
      end
    end
  end
end
