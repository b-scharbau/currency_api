class SymbolsController < ApplicationController
  def index
    @symbols = Currency.all.order(:symbol)

    render json: @symbols
  end
end
