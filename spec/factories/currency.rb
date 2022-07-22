FactoryBot.define do
  factory :currency do
    date { DateTime.now }
    description { 'Euro' }
    symbol { 'EUR' }
  end
end
