# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCurrency::AddRates do
  subject { described_class.new(currencies).call }
  let(:currencies) { %w[EUR USD] }

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

  shared_examples 'sets the rates' do
    it 'calls add_rate with the correct arguments' do
      subject

      expect(Money).to have_received(:add_rate).twice
      expect(Money).to have_received(:add_rate).with('EUR', 'USD', 1.42)
      expect(Money).to have_received(:add_rate).with('USD', 'EUR', 1 / 1.42)
    end
  end

  context 'when given currencies' do
    include_examples 'sets the rates'
  end

  context 'when given currencies in symbols' do
    let(:currencies) { %i[EUR USD] }

    include_examples 'sets the rates'
  end

  context 'when given currencies in Currency instances' do
    let(:eur) { Money::Currency.new('EUR') }
    let(:usd) { Money::Currency.new('USD') }
    let(:currencies) { [eur, usd] }

    include_examples 'sets the rates'
  end
end
