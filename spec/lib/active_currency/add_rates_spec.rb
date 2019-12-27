# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCurrency::AddRates do
  let(:currencies) { %w[EUR USD CAD] }

  # Mock bank
  let(:bank) { instance_double EuCentralBank, update_rates: nil }
  before do
    allow(EuCentralBank).to receive(:new) { bank }
    allow(bank).to receive(:get_rate).with('EUR', 'USD') { 1.42 }
    allow(bank).to receive(:get_rate).with('EUR', 'CAD') { 1.12 }
  end

  # Mock store
  let(:store) { instance_double ActiveCurrency::RateStore, add_rate: nil }
  before do
    allow(ActiveCurrency::RateStore).to receive(:new) { store }
  end

  shared_examples 'sets the rates' do
    it 'calls add_rate with the correct arguments' do
      subject

      expect(store).to have_received(:add_rate).exactly(4).times
      expect(store).to have_received(:add_rate).with('EUR', 'USD', 1.42)
      expect(store).to have_received(:add_rate).with('USD', 'EUR', 1 / 1.42)
      expect(store).to have_received(:add_rate).with('EUR', 'CAD', 1.12)
      expect(store).to have_received(:add_rate).with('CAD', 'EUR', 1 / 1.12)
    end
  end

  describe '#call' do
    subject { described_class.new(currencies).call }

    include_examples 'sets the rates'

    context 'with a custom bank' do
      subject { described_class.new(currencies, bank: bank).call }
      let(:bank) { double :bank, update_rates: nil }

      include_examples 'sets the rates'
    end

    context 'when given a variety of currency formats' do
      let(:currencies) { ['eur', :USD, Money::Currency.new('CAD')] }

      include_examples 'sets the rates'
    end
  end

  describe '.call' do
    subject { described_class.call(currencies) }

    include_examples 'sets the rates'

    context 'with a custom bank' do
      subject { described_class.call(currencies, bank: bank) }
      let(:bank) { double :bank, update_rates: nil }

      include_examples 'sets the rates'
    end
  end
end
