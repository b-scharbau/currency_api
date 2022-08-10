class Currency::FetchCase
  include ActiveModel::Model

  attr_accessor :currency

  def perform
    client.get_currency(currency.symbol) do |result|
      currency.date = result[:date]

      result[:rates].each do |key, rate|
        other_currency = Currency.find_by(symbol: key)
        next unless other_currency
        exchange_rate = ExchangeRate.find_or_initialize_by(currency: currency, other: other_currency)
        exchange_rate.rate = rate
        currency.exchange_rates << exchange_rate
      end
    end

    currency.save

    return currency
  end

  private

  def client
    @client ||= Apilayer::Currency::Client.new
  end
end
