class Apilayer::NetworkConnector
  BASE_URL = 'https://api.apilayer.com/exchangerates_data/'

  def get(path, query)
    response = HTTParty.get(
      "#{BASE_URL}/#{path}",
      headers: headers,
      query: query
    )

    raise "Could not fetch data" unless response.code == 200

    return response.body
  end

  private

  def headers
    @headers ||= {
      apikey: Rails.application.credentials.apilayer[:api_key],
    }
  end
end
