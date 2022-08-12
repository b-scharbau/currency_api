require 'rails_helper'

RSpec.describe Currency::FetchCase, type: :worker do
  let(:instance) { described_class.new(currency: currency) }
  let(:subject) { instance.perform }

  let(:client) { instance_double(Apilayer::Currency::Client) }

  before do
    allow(Apilayer::Currency::Client).to receive(:new).and_return(client)
  end

  let(:currency) do
    create(:currency,
      date: DateTime.now,
      symbol: 'EUR',
    )
  end
  let(:other) do
    create(:currency,
      symbol: 'JPY',
    )
  end
  let!(:exchange_rate) do
    create(:exchange_rate,
           currency: currency,
           other: other,
           rate: 130.0
         )
  end

  let(:data) do
    {
      date: DateTime.parse('2120-10-10 10:00:00+0000'),
      rates: {
        USD: 1.5,
        JPY: 140.0,
        AUD: 1.4,
      }
    }
  end

  before do
    create(:currency,
      symbol: 'USD',
    )

    allow(client).to receive(:get_currency).and_yield(data)
  end

  it 'calls #get_currency on api client' do
    expect(client).to receive(:get_currency).once
    subject
  end

  it 'creates new exchange rates' do
    expect do
      subject
    end.to change(ExchangeRate, :count).by(1)
  end

  it 'updates existing exchange rate' do
    subject
    expect(ExchangeRate.find_by(currency: currency, other: other).rate).to eq(140.0)
  end
end
