require 'net/http'

class FixerApi

  END_POINT = 'http://data.fixer.io/api'



  # Returns currency rates
  def currency_rates
    response
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
    URI.parse("#{END_POINT}/latest?access_key=#{ENV['SECRET_KEY']}")
  end
end