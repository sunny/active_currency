# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ActiveCurrency do
  it { expect(described_class).to be_a(Module) }
  it { expect(described_class::VERSION).to be_a(String) }
end
