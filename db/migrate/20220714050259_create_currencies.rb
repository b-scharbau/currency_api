class CreateCurrencies < ActiveRecord::Migration[6.1]
  def change
    create_table(:currencies, id: :string, primary_key: 'symbol') do |t|
      t.string :description
      t.datetime :date
    end
  end
end
