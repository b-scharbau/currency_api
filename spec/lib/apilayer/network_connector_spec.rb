require 'rails_helper'

RSpec.describe Apilayer::NetworkConnector, type: :worker do
  let(:instance) { described_class.new }
  let(:subject) { instance.get(path, query) }
  let(:path) { 'test' }
  let(:query) { { test: 'test' } }

  let(:http) { class_double(HTTParty) }
  let(:response) { double }

  let(:expected_url) { 'https://api.apilayer.com/exchangerates_data/test' }
  let(:expected_options) do
    {
      headers: {
        apikey: 'test_key'
      },
      query: {
        test: 'test'
      }
    }
  end

  context 'API call successful' do
    let(:expected_response) { { test: 'test' } }
    before do
      allow(HTTParty).to receive(:get).and_return(response)
      allow(response).to receive(:code).and_return(200)
      allow(response).to receive(:body).and_return({ test: 'test' })
    end

    it 'calls #get on HTTParty' do
      expect(HTTParty).to receive(:get).once
      subject
    end

    it 'calls #get on HTTParty with correct arguments' do
      expect(HTTParty).to receive(:get).once.with(expected_url, expected_options)
      subject
    end

    it { is_expected.to eq(expected_response) }
  end

  context 'API call unsuccessful' do
    before do
      allow(HTTParty).to receive(:get).and_return(response)
      allow(response).to receive(:code).and_return(401)
    end

    it 'calls #get on HTTParty' do
      expect(HTTParty).to receive(:get).once
      subject
    rescue
    end

    it 'calls #get on HTTParty with correct arguments' do
      expect(HTTParty).to receive(:get).once.with(expected_url, expected_options)
      subject
    rescue
    end

    it 'raises an error' do
       expect { subject }.to raise_error("Could not fetch data")
     end
  end
end
