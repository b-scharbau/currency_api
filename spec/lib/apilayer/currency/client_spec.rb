require 'rails_helper'

RSpec.describe Apilayer::Currency::Client, type: :worker do
  let(:instance) { described_class.new }
  let(:subject) { instance.get_currency(symbol) }
  let(:symbol) { 'EUR' }

  let(:connector) { instance_double(Apilayer::NetworkConnector) }

  before do
    allow(Apilayer::NetworkConnector).to receive(:new).and_return(connector)
  end

  it 'calls #get on network connector' do
    expect(connector).to receive(:get).once
    subject
  end

  it 'calls #get on network connector with correct parameters' do
    expect(connector).to receive(:get).with('latest', {base: 'EUR'})
    subject
  end

  context 'api call successful' do
    before do
      allow(connector).to receive(:get).and_return({test: 'Test'}.to_json)
    end

    let(:expected_response) { { test: 'Test' } }

    context 'no block given' do
      let(:subject) { instance.get_currency(symbol) }

      it { is_expected.to eq(expected_response) }
    end

    context 'block given' do
      it 'yields correct parameter' do
        expect { |b| instance.get_currency(symbol, &b) }
          .to yield_with_args(expected_response)
      end
    end
  end

  context 'api call unsuccesful' do
    before do
      allow(connector).to receive(:get).and_raise('some_error')
    end

    context 'no block given' do
      let(:subject) { instance.get_currency(symbol) }

      it { is_expected.to be_nil }
    end

    context 'block given' do
      it 'yields correct parameter' do
        expect { |b| instance.get_currency(symbol, &b) }
          .not_to yield_control
      end
    end
  end
end
