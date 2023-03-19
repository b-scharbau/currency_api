require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Symbols' do
  explanation 'Currency Symbols are used to describe a currency'

  header 'Accept', 'application/json'
  header 'content-type', 'application/json; charset=utf-8'

  let(:result) { JSON.parse(response_body, symbolize_names: true) }

  let(:connector) { instance_double(Apilayer::NetworkConnector) }

  before do
    allow(Apilayer::NetworkConnector).to receive(:new).and_return(connector)
    allow(connector).to receive(:get).and_return({rates: [], date: Time.new("2023-03-19T00:00:00+0000")}.to_json)
  end

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

  get '/symbols/:id' do
    explanation 'Fetch a single currency with its exchange rates'

    before do
      eur = create(:currency, date: "2020-12-12", description: 'Euro', symbol: 'EUR')
      usd = create(:currency, date: "2020-12-12", description: 'US Dollar', symbol: 'USD')
      jpy = create(:currency, date: "2020-12-12", description: 'Japanese Yen', symbol: 'JPY')
      create(:exchange_rate, currency: eur, other: eur, rate: 1.0)
      create(:exchange_rate, currency: eur, other: jpy, rate: 137.869631)
      create(:exchange_rate, currency: eur, other: usd, rate: 1.00435)
    end

    let(:expected_response) do
      {
        date: "2023-03-19",
        description: 'Euro',
        rates:
        [
          {
            "other": "EUR",
            "rate": 1.0
          },
          {
            "other": "JPY",
            "rate": 137.869631
          },
          {
            "other": "USD",
            "rate": 1.00435
          },
        ],
        symbol: 'EUR',
      }
    end

    let(:id) { 'EUR' }

    example_request 'GET /symbols/:symbol: return currency symbols' do
      expect(response_status).to be(200)
      expect(result[:symbol]).to eq(expected_response)
    end
  end
end
