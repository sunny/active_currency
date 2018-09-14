require 'spec_helper'

RSpec.describe ActiveCurrency::Rate do
  before { ActiveCurrency::Rate.delete_all }

  describe '.current_value_for' do
    let!(:latest_rate) do
      ActiveCurrency::Rate.create!(
        from: 'EUR',
        to: 'USD',
        value: 1.42,
        created_at: 1.hour.ago
      )
    end

    let!(:oldest_rate) do
      ActiveCurrency::Rate.create!(
        from: 'EUR',
        to: 'USD',
        value: 1.5,
        created_at: 1.month.ago
      )
    end

    it 'returns the latest value' do
      expect(described_class.current_value_for('EUR', 'USD')).to eq(1.42)
    end

    it 'accepts a date' do
      expect(described_class.current_value_for('EUR', 'USD', 1.day.ago))
        .to eq(1.5)
    end

    it 'returns nil with unexisting currencies' do
      expect(described_class.current_value_for('EUR', 'CAD')).to be_nil
    end
  end
end
