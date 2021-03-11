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

  def to_s
    str_name = name
    str_name = "imported #{name}" if imported
    return "#{qty}, #{str_name}, "
  end

end