class Currency::ShowCase
  include ActiveModel::Model

  attr_accessor :currency_id

  def perform
    currency = Currency.find(currency_id)

    if currency.date < Time.now - 24.hours
      currency = Currency::FetchCase.new(currency: currency).perform
    end

    return currency
  end

  private

  def client
    @client ||= Apilayer::Currency::Client.new
  end
end
