class ExchangeRate < ApplicationRecord
  belongs_to :currency, foreign_key: 'currency_symbol'
  belongs_to :other, foreign_key: 'other_symbol', class_name: 'Currency'

  validates :rate, presence: true
end
