require 'rails_helper'

RSpec.describe Currency, type: :model do
  context 'validations' do
     it { is_expected.to validate_presence_of(:date) }
     it { is_expected.to validate_presence_of(:description) }
     it { is_expected.to validate_presence_of(:symbol) }
  end
end
