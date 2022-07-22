class CreateExchangeRates < ActiveRecord::Migration[6.1]
  def change
    create_table :exchange_rates do |t|
      t.string :currency_symbol, null: false
      t.string :other_symbol, null: false

      t.float :rate
    end

    add_foreign_key :exchange_rates, :currencies, column: 'currency_symbol', primary_key: 'symbol'
    add_foreign_key :exchange_rates, :currencies, column: 'other_symbol', primary_key: 'symbol'
  end
end
