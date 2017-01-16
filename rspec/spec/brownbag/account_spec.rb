# I don't want to be bothered with line lenght here.
# rubocop:disable Metrics/LineLength
require 'spec_helper'
require 'brownbag_rspec/account'

describe BrownbagRspec::Account do
  # Helper function
  def new_balance
    BrownbagRspec::Account.new.balance
  end

  # Implicit subject!
  # `subject` function returns the subject of the examples.
  #
  # subject { Account.new }

  # You can create before/after/around hooks for suite/context/examples
  after(:example) { expect(subject.balance).to be >= new_balance }

  describe '#new' do
    # one-liner syntax. `is_expected` is the same as `expect(subject)`
    it { is_expected.to respond_to(:balance) }
    it { is_expected.to respond_to(:deposit, :withdrow).with(1).argument }

    # You can nest `describe`. `describe` and `context` are the same.
    describe '#balance' do
      it 'should be 0' do
        # expect(subject.balance).to(be(0))
        expect(subject.balance).to be 0
      end
    end
  end

  describe '#deposit' do
    it 'should increase balance' do
      # You can code inside an example.
      subject.deposit(10)
      # expect(subject.balance).to(be() > 0)
      expect(subject.balance).to be > 0
    end
    # `subject` resets before each example.
    it 'should return new balance' do
      expect(subject.deposit(5)).to be 5
    end
  end

  describe '#withdrow' do
    context 'when balance is high enough' do
      # `let` is a memoized helper function
      let(:initial_amount) { 5 }

      # I could have set this hook in the outer context, and use it lower
      # contexts.
      before(:example) { subject.deposit(initial_amount) }

      it 'should change the balance' do
        # Notice the curly brackets!
        expect { subject.withdrow(3) }.to change(subject, :balance).from(initial_amount).to(initial_amount - 3)
      end
    end

    context 'when balance is not high enough' do
      before(:example) { subject.deposit(5) }

      it 'should raise an error' do
        # You can catch exceptions!
        expect { subject.withdrow(7) }.to raise_error('Not enough money')
      end
    end
  end
end
