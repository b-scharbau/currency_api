class Apilayer::Currency::Client
  PATH = 'latest'

  def get_currency(symbol)
    query = {
      base: symbol
    }

    begin
      response = connector.get(query, PATH)

      result = JSON.parse(response).symbolize_keys
    rescue => error
      Rails.logger.error "Exception caused during API query: #{error.message}"
      return
    end

    if block_given?
      yield result
    else
      return result
    end
  end

  private

  def connector
    @connector ||= Apilayer::NetworkConnector.new
  end
end
