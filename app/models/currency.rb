class Currency < ApplicationRecord
   validates :date, :description, :symbol, presence: true

   has_many :exchange_rates, primary_key: 'symbol', foreign_key: 'currency_symbol'
end
