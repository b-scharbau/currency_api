class CurrencySerializer < ActiveModel::Serializer
  attributes :symbol, :description, :date
end
