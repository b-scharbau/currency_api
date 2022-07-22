FactoryBot.define do
  factory :exchange_rate do
    association :currency, factory: :currency
    association :other, factory: :currency

    rate { 1.0 }
  end
end
