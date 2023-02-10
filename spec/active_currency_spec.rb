# frozen_string_literal: true

require "spec_helper"

RSpec.describe ActiveCurrency do
  it { expect(described_class).to be_a(Module) }
  it { expect(described_class::VERSION).to be_a(String) }

  describe ".configure" do
    it "yields configuration" do
      expect { |block| described_class.configure(&block) }
        .to yield_with_args(described_class.configuration)
    end
  end

  describe ".configuration" do
    it "returns a configuration" do
      expect(described_class.configuration)
        .to be_a(described_class::Configuration)
    end
  end

  describe ".remote_bank" do
    context "when remote bank is the default" do
      it "returns an instance of EuCentralBank" do
        expect(described_class.remote_bank).to be_a(EuCentralBank)
      end
    end

    context "when remote bank is open exchange rates" do
      before do
        described_class.configuration.remote_bank = :open_exchange_rates
        described_class.configuration.open_exchange_rates_app_id = "123"
      end

      after do
        described_class.configuration.remote_bank = :eu_central_bank
        described_class.configuration.open_exchange_rates_app_id = nil
      end

      it "returns an instance of OpenExchangeRatesBank" do
        expect(described_class.remote_bank)
          .to be_a(Money::Bank::OpenExchangeRatesBank)
      end
    end
  end
end
