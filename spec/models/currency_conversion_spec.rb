require 'rails_helper'

RSpec.describe CurrencyConversion, :type => :model do
  let(:valid_attributes) {
      { base_currency: "EUR", base_amount: 4, target_currency: "INR", week_count: 2 }
  }

  describe "#get_data" do
    it "returns hash" do
      cc = CurrencyConversion.create! valid_attributes
      result = CurrencyConversion.get_data(cc)
      expect(result.count).to eq(2) 
      expect(result.class).to eq(Hash) 
    end
  end
end