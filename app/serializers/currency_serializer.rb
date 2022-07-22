class CurrencySerializer < ActiveModel::Serializer
  type :symbol
  
  attributes :symbol, :description
end
