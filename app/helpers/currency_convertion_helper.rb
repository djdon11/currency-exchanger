module CurrencyConvertionHelper
  def min_max_class(value, rates_array)
    if value == rates_array.values.min 
      'lowest'
    elsif value == rates_array.values.max
      'highest'
    end
  end
end
