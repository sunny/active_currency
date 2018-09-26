# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCurrency::AddRates do
  subject { described_class.new(currencies).call }
  let(:currencies) { %w[EUR USD CAD] }

  # Mock EuCentralBank
  before do
    allow_any_instance_of(EuCentralBank)
      .to receive(:update_rates)
    allow_any_instance_of(EuCentralBank)
      .to receive(:get_rate).with('EUR', 'USD') { 1.42 }
    allow_any_instance_of(EuCentralBank)
      .to receive(:get_rate).with('EUR', 'CAD') { 1.12 }
  end

  # Mock Money
  before do
    allow(Money).to receive(:add_rate)
  end

  shared_examples 'sets the rates' do
    it 'calls add_rate with the correct arguments' do
      subject

      expect(Money).to have_received(:add_rate).exactly(4).times
      expect(Money).to have_received(:add_rate).with('EUR', 'USD', 1.42)
      expect(Money).to have_received(:add_rate).with('USD', 'EUR', 1 / 1.42)
      expect(Money).to have_received(:add_rate).with('EUR', 'CAD', 1.12)
      expect(Money).to have_received(:add_rate).with('CAD', 'EUR', 1 / 1.12)
    end
  end

  include_examples 'sets the rates'

  context 'when given a variety of currency formats' do
    let(:currencies) { ['eur', :USD, Money::Currency.new('CAD')] }

    include_examples 'sets the rates'
  end
end
