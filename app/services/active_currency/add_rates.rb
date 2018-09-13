module ActiveCurrency
  # Store the latest currency rates.
  class AddRates
    def call
      currencies = Money.default_bank.store.currencies - ["EUR"]
      return if currencies.blank?

      bank = EuCentralBank.new
      bank.update_rates

      from = "EUR"
      currencies.each do |to|
        rate = bank.get_rate(from, to)

        Money.add_rate(from, to, rate)
        Money.add_rate(to, from, 1 / rate)
      end
    end
  end
end
