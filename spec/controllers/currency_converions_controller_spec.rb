require 'rails_helper'

RSpec.describe CurrencyConversionsController, type: :controller do

  let(:valid_attributes) {
      { base_currency: "EUR", base_amount: 3, target_currency: "INR", week_count:2 }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      2.times{ CurrencyConversion.create! valid_attributes }
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
      expect(CurrencyConversion.count).to eq(2)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      @cc = CurrencyConversion.create! valid_attributes
      get :edit, params: {id: @cc.id }
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      @cc = CurrencyConversion.create! valid_attributes
      @data = CurrencyConversion.get_data(@cc)
      @chart = HighchartGraphs.new(@data.keys, @data.values).draw
      @current_rate = FixerApi.new(@cc).currency_rates
      get :show, params: {id: @cc.id }
      expect(response).to be_successful
    end
  end

  describe "GET #create" do
    it "returns a success response" do
      post :create, params: { currency_conversion: valid_attributes }
      expect(CurrencyConversion.count).to eq(1)
    end
  end

  describe "GET #update" do
    it "returns a success response" do
      @cc = CurrencyConversion.create! valid_attributes
      post :update, params: { id: @cc.id, currency_conversion: valid_attributes  }
      expect(CurrencyConversion.count).to eq(1)
    end
  end

  describe "GET #destroy" do
    it "returns a success response" do
      @cc = CurrencyConversion.create! valid_attributes
      get :destroy, params: {id: @cc.id }
      expect(CurrencyConversion.count).to eq(0)
    end
  end
end