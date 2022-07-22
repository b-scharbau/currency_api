require 'rails_helper'

RSpec.describe ExchangeRate, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:currency) }
    it { is_expected.to belong_to(:other) }
  end

  context 'validations' do
     it { is_expected.to validate_presence_of(:rate) }
  end
end
