# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCurrency::AddRates do
  subject { described_class.new.call }

  # Mock EuCentralBank
  before do
    allow_any_instance_of(EuCentralBank)
      .to receive(:update_rates)
    allow_any_instance_of(EuCentralBank)
      .to receive(:get_rate).with('EUR', 'USD') { 1.42 }
  end

  # Mock Money
  before do
    allow(Money).to receive(:add_rate)
  end

  it 'sets the rate' do
    subject

    expect(Money).to have_received(:add_rate).twice
    expect(Money).to have_received(:add_rate).with('EUR', 'USD', 1.42)
    expect(Money).to have_received(:add_rate).with('USD', 'EUR', 1 / 1.42)
  end

  context 'when the bank store is in symbols' do
    before do
      allow(Money.default_bank.store).to receive(:currencies) { %i[EUR USD] }
    end

    it 'sets the rate' do
      subject

      expect(Money).to have_received(:add_rate).twice
    end
  end

  context 'when the bank store is in currencies' do
    let(:eur) { Money::Currency.new('EUR') }
    let(:usd) { Money::Currency.new('USD') }

    before do
      allow(Money.default_bank.store).to receive(:currencies) { [eur, usd] }
    end

    it 'sets the rate' do
      subject

      expect(Money).to have_received(:add_rate).twice
    end
  end
end
