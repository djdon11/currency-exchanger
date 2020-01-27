require 'net/http'

class FixerApi

  END_POINT = 'http://data.fixer.io/api'

  # Not sure if we need these as attr_reader
  # but may be later we want them to be access
  # outside from this class
  attr_reader :currency
  attr_reader :target_date

  def initialize(currency, target_date = 'latest')
    @currency = currency
    @target_date = target_date
  end

  # Returns currency rates for/from target_date
  def currency_rates
    response['rates'][currency.target_currency.to_s]
  end

  private

  # Recieve response from Fixer API
  def response
    payload
  rescue Net::OpenTimeout => e
    Rails.logger.debug(e)
  end

  # Request to API and prepare resonse
  def payload
    uri = end_point
    JSON.parse(Net::HTTP.get(uri))
  end

  # Prepare API end point
  def end_point
    url = "#{END_POINT}/#{@target_date}?access_key=#{ENV['SECRET_KEY']}&symbols=#{@currency.target_currency}"
    Rails.cache.fetch("#{url}", :expires_in => 12.hours, cache_nils: false) do
      URI.parse("#{url}")
    end
  end
end