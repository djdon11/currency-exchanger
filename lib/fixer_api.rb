require 'net/http'

class FixerApi

  END_POINT = 'http://data.fixer.io/api'

  # Not sure if we need these as attr_reader
  # but may be later we want them to be access
  # outside from this class
  attr_reader :currency
  attr_reader :target_date

  def initialize(currency='INR', target_date='latest')
    @currency = currency
    @target_date = target_date
  end

  # Returns currency rates for/from target_date
  def currency_rates
    response['rates'][currency]
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
    URI.parse("#{END_POINT}/#{@target_date}?access_key=ENV['SECRET_KEY']&symbols=#{@currency}")
  end
end