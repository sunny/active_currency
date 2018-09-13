require "spec_helper"

RSpec.describe ActiveCurrency::AddRates do
  subject { described_class.new.call }

  # Mock EuCentralBank
  before do
    allow_any_instance_of(EuCentralBank)
      .to receive(:update_rates)
    allow_any_instance_of(EuCentralBank)
      .to receive(:get_rate).with("EUR", "USD") { 1.42 }
  end

  # Mock Money
  before do
    allow(Money).to receive(:add_rate)
  end

  it "sets the rate" do
    subject

    expect(Money).to have_received(:add_rate).with("EUR", "USD", 1.42)
    expect(Money).to have_received(:add_rate).with("USD", "EUR", 1 / 1.42)
  end
end
