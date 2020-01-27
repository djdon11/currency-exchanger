class CurrencyConversionsController < ApplicationController
  before_action :set_currency_conversion, only: %i[show edit update destroy]

  # GET /currency_conversions
  # GET /currency_conversions.json
  def index
    @currency_conversion = CurrencyConversion.new
    @currency_conversions = CurrencyConversion.all
  end

  # GET /currency_conversions/1
  # GET /currency_conversions/1.json
  def show
    @data = CurrencyConversion.get_data(@currency_conversion)
    @chart = HighchartGraphs.new(@data.keys, @data.values).draw
    @current_rate = FixerApi.new(@currency_conversion).currency_rates
  end

  # GET /currency_conversions/new
  def new
    @currency_conversion = CurrencyConversion.new
  end

  # GET /currency_conversions/1/edit
  def edit; end

  # POST /currency_conversions
  # POST /currency_conversions.json
  def create
    @currency_conversion = CurrencyConversion.new(currency_conversion_params)

    respond_to do |format|
      if @currency_conversion.save
        format.html { redirect_to @currency_conversion, notice: 'Currency Conversion was successfully created.' }
        format.json { render :show, status: :created, location: @currency_conversion }
      else
        format.html { render :new }
        format.json { render json: @currency_conversion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /currency_conversions/1
  # PATCH/PUT /currency_conversions/1.json
  def update
    respond_to do |format|
      if @currency_conversion.update(currency_conversion_params)
        format.html { redirect_to @currency_conversion, notice: 'Currency Conversion was successfully updated.' }
        format.json { render :show, status: :ok, location: @currency_conversion }
      else
        format.html { render :edit }
        format.json { render json: @currency_conversion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /currency_conversions/1
  # DELETE /currency_conversions/1.json
  def destroy
    @currency_conversion.destroy
    respond_to do |format|
      format.html { redirect_to currency_conversions_url, notice: 'Currency Conversion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Set currency_conversion
  def set_currency_conversion
    @currency_conversion = CurrencyConversion.find(params[:id])
  end

  # Whilelist params
  def currency_conversion_params
    params.require(:currency_conversion).permit(:base_currency, :target_currency, :base_amount, :week_count)
  end
end
