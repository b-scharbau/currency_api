require 'rails_helper'

RSpec.describe ExchangeRate, type: :model do
  it 'has a valid factory' do
    expect(create(:exchange_rate)).to be_valid
  end

  context 'associations' do
    it { is_expected.to belong_to(:currency) }
    it { is_expected.to belong_to(:other) }
  end

  context 'validations' do
     it { is_expected.to validate_presence_of(:rate) }
  end
end
