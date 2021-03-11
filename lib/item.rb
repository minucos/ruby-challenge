class Item
  attr_reader :name, :price, :taxes, :qty, :imported

  def initialize(options)
    @qty = options[:qty]
    @name = options[:name]
    @price = options[:price]
    @taxes = options[:taxes]
    @imported = options[:imported]
  end

  def tax_rate
    rate = 0

    taxes.each { |tax| rate += tax.rate }

    return rate
  end

  def tax
    amt = price * tax_rate / 100.0

    round_amt = (amt * 20).round / 20.0

    return round_amt + 0.05 if round_amt < amt
    return round_amt
  end

  def inc_price
    return price + tax
  end

  def receipt_name
    return "imported #{name}" if imported
    return name
  end

  def receipt_price
    return "%.2f" % inc_price
  end

  def to_s
    return "#{qty}, #{receipt_name}, #{receipt_price}"
  end

end