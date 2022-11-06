# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCurrency::Rate do
  before { described_class.delete_all }

  around { |example| Timecop.freeze(now, &example) }

  let(:now) { Time.new(2018, 9, 14).in_time_zone }
  let(:earlier) { Time.new(2018, 9, 13).in_time_zone }
  let(:a_long_time_ago) { Time.new(2018, 1, 1).in_time_zone }

  describe '.value_for' do
    let!(:latest_rate) do
      described_class.create!(
        from: 'EUR',
        to: 'USD',
        value: 1.42,
        created_at: earlier
      )
    end

    let!(:oldest_rate) do
      described_class.create!(
        from: 'EUR',
        to: 'USD',
        value: 1.5,
        created_at: a_long_time_ago
      )
    end

    it 'returns the latest value' do
      expect(described_class.value_for('EUR', 'USD')).to eq(1.42)
    end

    it 'accepts a date' do
      expect(described_class.value_for('EUR', 'USD', 1.day.ago)).to eq(1.5)
    end

    it 'returns nil with currencies that do not exist yet' do
      expect(described_class.value_for('EUR', 'CAD')).to be_nil
    end

    it 'returns 1 for the same currency' do
      expect(described_class.value_for('EUR', 'EUR')).to eq(1)
      expect(described_class.value_for('USD', 'USD')).to eq(1)
    end

    it 'accepts different currency formats' do
      expect(described_class.value_for(:eur, Money::Currency.new('USD')))
        .to eq(1.42)
    end
  end
end
