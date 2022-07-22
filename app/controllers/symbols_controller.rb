class SymbolsController < ApplicationController
  before_action :set_currency, only: [:show]

  def index
    @symbols = Currency.all.order(:symbol)

    render json: @symbols
  end

  def show
    render json: @symbol, serializer: CurrencyDetailSerializer
  end

  private

  def set_currency
    @symbol = Currency.find(params[:id])
  end
end
