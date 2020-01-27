class CreateCurrencyConversions < ActiveRecord::Migration[6.0]
  def change
    create_table :currency_conversions do |t|
      t.string :base_currency
      t.string :target_currency
      t.bigint :base_amount
      t.integer :week_count

      t.timestamps
    end
  end
end
