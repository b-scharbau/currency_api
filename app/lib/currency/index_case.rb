class Currency::IndexCase
  def perform
    return Currency.all.order(:symbol)
  end
end
