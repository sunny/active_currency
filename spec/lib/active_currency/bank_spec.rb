# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCurrency::Bank do
  subject { described_class.new }

  it 'creates a bank' do
    expect(subject).to be_kind_of(Money::Bank::VariableExchange)
    expect(subject.store).to be_kind_of(ActiveCurrency::RateStore)
  end
end
