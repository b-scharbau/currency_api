FactoryBot.define do
  factory :exchange_rate do
    association :currency, factory: :euro
    association :other, factory: :dollar

    rate { 1.0 }
  end
end
