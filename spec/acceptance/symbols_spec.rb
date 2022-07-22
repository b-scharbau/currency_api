require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Symbols' do
  explanation 'Currency Symbols are used to describe a currency'

  header 'Accept', 'application/json'
  header 'content-type', 'application/json; charset=utf-8'

  let(:result) { JSON.parse(response_body, symbolize_names: true) }

  get '/symbols' do
    explanation 'Fetch a list of all currency symbols available for conversion'

    let(:expected_response) do
      [
        {
          symbol: 'EUR',
          description: 'Euro'
        },
        {
          symbol: 'JPY',
          description: 'Japanese Yen'
        },
        {
          symbol: 'USD',
          description: 'US Dollar'
        }
      ]
    end

    before do
      create(:currency, date: "2020-12-12", description: 'Euro', symbol: 'EUR')
      create(:currency, date: "2020-12-12", description: 'US Dollar', symbol: 'USD')
      create(:currency, date: "2020-12-12", description: 'Japanese Yen', symbol: 'JPY')
    end

    example_request 'GET /symbols: return currency symbols' do
      expect(response_status).to be(200)
      expect(result[:symbols]).to eq(expected_response)
    end
  end
end
