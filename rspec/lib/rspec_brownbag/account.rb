module RSpecBrownbag
  # Simple bank account class for RSpec Brownbag session
  #
  # @example usage
  #   require 'brownbag-rspec/account'
  #
  #   my_account = Brownbag::Account.new
  #   puts "I'm so broken :'( I've got #{my_account.balance} quids"
  class Account
    attr_reader :balance

    def initialize
      @balance = 0
    end

    # Increase the account balance
    #
    # @param [Integer] amount represents the amount of money to deposit
    def deposit(amount)
      @balance += amount
    end

    # Increase the account balance
    #
    # @param [Integer] amount represents the amount of money to withdraw
    #
    # @raise [StandardError] if `amount` is greater than the balance
    def withdraw(amount)
      raise 'Not enough money' unless amount <= balance
      @balance -= amount
    end
  end
end
