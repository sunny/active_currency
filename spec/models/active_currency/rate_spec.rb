# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCurrency::Rate do
  before { ActiveCurrency::Rate.delete_all }

  around { |example| Timecop.freeze(now, &example) }

  let(:now) { Time.new(2018, 9, 14).in_time_zone }
  let(:earlier) { Time.new(2018, 9, 13).in_time_zone }
  let(:a_long_time_ago) { Time.new(2018, 1, 1).in_time_zone }

  describe '.value_for' do
    let!(:latest_rate) do
      ActiveCurrency::Rate.create!(
        from: 'EUR',
        to: 'USD',
        value: 1.42,
        created_at: earlier
      )
    end

    let!(:oldest_rate) do
      ActiveCurrency::Rate.create!(
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

    it 'returns nil with unexisting currencies' do
      expect(described_class.value_for('EUR', 'CAD')).to be_nil
    end
  end
end
