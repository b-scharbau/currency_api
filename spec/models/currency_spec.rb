require 'rails_helper'

RSpec.describe Currency, type: :model do
  it 'has a valid factory' do
    expect(create(:currency)).to be_valid
  end

  context 'associations' do
    it { is_expected.to have_many(:exchange_rates) }
  end

  context 'validations' do
     it { is_expected.to validate_presence_of(:date) }
     it { is_expected.to validate_presence_of(:description) }
     it { is_expected.to validate_presence_of(:symbol) }
  end
end
