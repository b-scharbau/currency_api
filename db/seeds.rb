# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Currency.create([
  {
    date: "2022-07-23",
    description: "Australian Dollar",
    symbol: "AUD"
  },
  {
    date: "2022-07-23",
    description: "Canadian Dollar",
    symbol: "CAD"
  },
  {
    date: "2022-07-23",
    description: "Chinese Yuan",
    symbol: "CNY"
  },
  {
    date: "2022-07-23",
    description: "Euro",
    symbol: "EUR"
  },
  {
    date: "2022-07-23",
    description: "British Pound Sterling",
    symbol: "GBP"
  },
  {
    date: "2022-07-23",
    description: "Japanese Yen",
    symbol: "JPY"
  },
  {
    date: "2022-07-23",
    description: "United States Dollar",
    symbol: "USD"
  },
])
