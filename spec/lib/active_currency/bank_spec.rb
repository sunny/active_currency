# frozen_string_literal: true

require "spec_helper"

RSpec.describe ActiveCurrency::Bank do
  let(:bank) { described_class.new }

  it "is a bank" do
    expect(bank).to be_a(Money::Bank::VariableExchange)
    expect(bank.store).to be_a(ActiveCurrency::RateStore)
  end
end
