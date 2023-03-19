FactoryBot.define do
  factory :currency do
    date { DateTime.now }
    description { 'Euro' }
    symbol { 'EUR' }

    factory :euro do
      description { 'Euro' }
      symbol { 'EUR' }
    end

    factory :dollar do
      description { 'Dollar' }
      symbol { 'USD' }
    end
  end
end
