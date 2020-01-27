class CurrencyConversion < ApplicationRecord
	CURRENCIES = %w[AUD BGN BRL CAD CHF CNY CZK DKK EUR GBP HKD HRK HUF IDR ILS INR 
		              JPY KRW MXN MYR NOK NZD PHP PLN RON RUB SEK SGD THB TRY USD ZAR].freeze

  def self.get_data(currency_conversion)
    hash = {}
    currency_conversion.week_count.times do |n|
      date = (Date.today - (n + 1).weeks).strftime('%Y-%m-%d')
      hash[date.to_s] = FixerApi.new(currency_conversion, date).currency_rates
    end
    hash
  end
end
