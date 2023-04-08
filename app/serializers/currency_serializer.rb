class CurrencySerializer < ActiveModel::Serializer
  type :symbol

  attributes :symbol, :description

  attribute :date do
    object.date.strftime("%F")
  end
end
