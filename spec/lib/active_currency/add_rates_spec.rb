# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCurrency::AddRates do
  let(:currencies) { %w[EUR USD CAD] }

  shared_examples 'with a mocked EuCentralBank' do
    # Mock bank
    let(:bank) { instance_double EuCentralBank, update_rates: nil }
    before do
      allow(EuCentralBank).to receive(:new) { bank }
      allow(bank).to receive(:get_rate).with('EUR', 'USD') { 1.42 }
      allow(bank).to receive(:get_rate).with('USD', 'EUR') { nil }
      allow(bank).to receive(:get_rate).with('EUR', 'CAD') { 1.12 }
      allow(bank).to receive(:get_rate).with('CAD', 'EUR') { nil }
      allow(bank).to receive(:get_rate).with('CAD', 'USD') { nil }
      allow(bank).to receive(:get_rate).with('USD', 'CAD') { nil }
    end

    it 'updates the rates' do
      subject

      expect(bank).to have_received(:update_rates)
    end
  end

  shared_examples 'with a custom bank' do
    # Mock bank
    let(:bank) { double :bank, update_rates: nil }

    before do
      allow(bank).to receive(:get_rate).with('EUR', 'USD') { 1.42 }
      allow(bank).to receive(:get_rate).with('USD', 'EUR') { 1 / 1.42 }
      allow(bank).to receive(:get_rate).with('EUR', 'CAD') { 1.12 }
      allow(bank).to receive(:get_rate).with('CAD', 'EUR') { 1 / 1.12 }
      allow(bank).to receive(:get_rate).with('CAD', 'USD') { nil }
      allow(bank).to receive(:get_rate).with('USD', 'CAD') { nil }
    end

    it 'updates the rates' do
      subject

      expect(bank).to have_received(:update_rates)
    end
  end

  shared_examples 'sets the rates' do
    # Mock store
    let(:store) { instance_double ActiveCurrency::RateStore, add_rate: nil }
    before do
      allow(ActiveCurrency::RateStore).to receive(:new) { store }
    end

    it 'calls add_rate with the correct arguments' do
      subject

      expect(store).to have_received(:add_rate).exactly(6).times
      expect(store).to have_received(:add_rate).with('EUR', 'USD', 1.42)
      expect(store).to have_received(:add_rate).with('USD', 'EUR', 1 / 1.42)
      expect(store).to have_received(:add_rate).with('EUR', 'CAD', 1.12)
      expect(store).to have_received(:add_rate).with('CAD', 'EUR', 1 / 1.12)
      expect(store)
        .to have_received(:add_rate)
        .with('CAD', 'USD', a_value_within(0.0000001).of(1.42 / 1.12))
      expect(store)
        .to have_received(:add_rate)
        .with('USD', 'CAD', a_value_within(0.0000001).of(1.12 / 1.42))
    end
  end

  describe '#call' do
    subject { described_class.new(currencies).call }

    context 'when called' do
      include_examples 'with a mocked EuCentralBank'
      include_examples 'sets the rates'
    end

    context 'when given a variety of currency formats' do
      let(:currencies) { ['eur', :USD, Money::Currency.new('CAD')] }

      include_examples 'with a mocked EuCentralBank'
      include_examples 'sets the rates'
    end

    context 'when given a custom bank' do
      subject { described_class.new(currencies, bank: bank).call }

      include_examples 'with a custom bank'
      include_examples 'sets the rates'
    end
  end

  describe '.call' do
    subject { described_class.call(currencies) }

    context 'when called' do
      include_examples 'with a mocked EuCentralBank'
      include_examples 'sets the rates'
    end

    context 'when given a custom bank' do
      subject { described_class.new(currencies, bank: bank).call }

      include_examples 'with a custom bank'
      include_examples 'sets the rates'
    end

    context 'when given a variety of currency formats' do
      let(:currencies) { ['eur', :USD, Money::Currency.new('CAD')] }

      include_examples 'with a mocked EuCentralBank'
      include_examples 'sets the rates'
    end
  end
end
