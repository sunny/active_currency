# frozen_string_literal: true

require "spec_helper"

RSpec.describe ActiveCurrency::Configuration do
  let(:configuration) { described_class.new }

  it "accepts a remote bank" do
    expect(configuration.remote_bank).to eq(:eu_central_bank)
    configuration.remote_bank = :open_exchange_rates
    expect(configuration.remote_bank).to eq(:open_exchange_rates)
  end

  it "accepts an open exchange rates app id" do
    expect(configuration.open_exchange_rates_app_id).to be_nil
    configuration.open_exchange_rates_app_id = "123"
    expect(configuration.open_exchange_rates_app_id).to eq("123")
  end

  it "accepts a multiplier" do
    expect(configuration.multiplier).to eq({})
    configuration.multiplier = { %w[CAD USD] => 1.42 }
    expect(configuration.multiplier).to eq(%w[CAD USD] => 1.42)
  end
end
