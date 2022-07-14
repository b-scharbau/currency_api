class Currency < ApplicationRecord
   validates :date, :description, :symbol, presence: true
end
