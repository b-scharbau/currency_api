require 'rails_helper'

RSpec.describe Currency::FetchDataJob, type: :worker do
  let(:subject) { described_class.perform_now }

  let(:use_case) { instance_double(Currency::FetchCase) }

  before do
    allow(Currency::FetchCase).to receive(:new).and_return(use_case)
  end

  context 'single currency' do
    before do
      currency = create(:currency,
                        date: date,
                       )

      allow(use_case).to receive(:perform).and_return(currency)
    end

    context 'currency is older than today' do
      let(:date) { DateTime.now - 1.week }

      it 'calls #perform on use case' do
        expect(use_case).to receive(:perform)
        subject
      end
    end

    context 'currency is from today' do
      let(:date) { DateTime.now }

      it 'calls #perform on use case' do
        expect(use_case).not_to receive(:perform)
        subject
      end
    end
  end

  context 'multiple currencies' do
    let!(:currency_one) do
      create(:currency,
             date: DateTime.now,
             symbol: 'EUR',
           )
    end

    let!(:currency_two) do
      create(:currency,
             date: DateTime.now - 1.week,
             symbol: 'USD',
           )
    end

    before do
      allow(use_case).to receive(:perform).and_return(currency_two)
    end

    it 'calls #perform on use case once' do
      expect(Currency::FetchCase).to receive(:new).once
      subject
    end

    it 'calls #perform on use case with correct parameters' do
      expect(Currency::FetchCase).to receive(:new).with(currency: currency_two)
      subject
    end
  end
end
