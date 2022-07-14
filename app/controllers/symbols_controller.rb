class SymbolsController < ApplicationController
  def index
    @symbols = Currency.all

    render json: @symbols
  end
end
