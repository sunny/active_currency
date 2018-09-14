# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCurrency::MemoryRateStore do
  subject { described_class.new }

  describe '#get_rate' do
    it { expect(subject.get_rate('EUR', 'USD')).to be_nil }

    context 'after adding a rate' do
      before { subject.add_rate('EUR', 'USD', 1.42) }

      it { expect(subject.get_rate('EUR', 'USD')).to eq(1.42) }
    end
  end

  describe '#currencies' do
    it { expect(subject.currencies).to eq([]) }

    context 'after adding a rate' do
      before { subject.add_rate('EUR', 'USD', 1.42) }

      it { expect(subject.currencies).to eq(%w[EUR USD]) }
    end

    context 'after adding several rates' do
      before { subject.add_rate('EUR', 'USD', 1.42) }
      before { subject.add_rate('USD', 'EUR', 1 / 1.42) }

      it { expect(subject.currencies).to eq(%w[EUR USD]) }
    end
  end
end
