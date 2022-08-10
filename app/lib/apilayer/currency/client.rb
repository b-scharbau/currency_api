class Apilayer::Currency::Client
  def get_currency(symbol)

    query = {
      base: symbol
    }

    response = HTTParty.get(
      'https://api.apilayer.com/exchangerates_data/latest',
      headers: headers,
      query: query
    )

    if response.code == 200
      result = JSON.parse(response.body).symbolize_keys

      if block_given?
          yield result
        else
          return result
        end
    else
      return false
    end
  end

  private

  def headers
    @headers ||= {
      apikey: Rails.application.credentials.apilayer[:api_key],
    }
  end
end
