class Item
  attr_reader :name, :price, :taxes, :qty

  def initialize(options)
    @qty = options[:qty]
    @name = options[:name]
    @price = options[:price]
    @taxes = options[:taxes]
  end
end