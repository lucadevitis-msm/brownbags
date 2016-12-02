class Account
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def deposit(amount)
    @balance += amount
  end

  def withdrow(amount)
    raise 'Not enough money' unless amount <= balance
    @balance -= amount
  end
end
