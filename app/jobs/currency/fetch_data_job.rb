class Currency::FetchDataJob < ApplicationJob
  def perform(*args)
    Currency.find_each do |currency|
      date = currency.date.end_of_day

      if date < DateTime.now
        Rails.logger.info "Fetching new data for currency #{currency.symbol}"
        use_case = Currency::FetchCase.new(currency: currency)

        result = use_case.perform
        Rails.logger.info "New date: #{result.date.iso8601}"
      else
        Rails.logger.info "Skipping currency #{currency.symbol}"
      end
    end
  end
end
