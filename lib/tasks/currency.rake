namespace :currency do
  desc "Fetch most recent currency data from APILayer"
  task fetch: :environment do
    Currency::FetchDataJob.perform_now()
  end
end
