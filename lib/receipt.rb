class Receipt
  attr_reader :basket
  def initialize(basket)
    @basket = basket
  end

  def to_s
    str = ""
    basket.items.each do |item|
      str += "#{item}\n"
    end
    str += "\n"
    str += "Sales Taxes: #{basket.receipt_tax}\n"
    str += "Total: #{basket.receipt_total}\n"

    return str
  end
end