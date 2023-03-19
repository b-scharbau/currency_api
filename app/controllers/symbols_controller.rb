class SymbolsController < ApplicationController
  def index
    use_case = Currency::IndexCase.new
    symbols = use_case.perform

    render json: symbols
  end

  def show
    use_case = Currency::ShowCase.new(currency_id: params[:id])
    symbol = use_case.perform

    render json: symbol, serializer: CurrencyDetailSerializer
  end
end
