class CurrencyDetailSerializer < ActiveModel::Serializer
  type :symbol

  attributes :description, :symbol

  has_many :exchange_rates, key: :rates

  attribute :date do
    object.date.strftime("%F")
  end

  class ExchangeRateSerializer < ActiveModel::Serializer
    type :rate

    attributes :rate

    attribute :other do
      object.other_symbol
    end
  end
end
