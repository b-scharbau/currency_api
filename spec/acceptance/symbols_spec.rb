require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Symbols" do
  get "/symbols" do
    example "Listing symbols" do
      do_request

      expect(status).to eq 200
    end
  end
end
