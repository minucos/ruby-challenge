require "csv"
require_relative "./tax"
require_relative "./item"

class LoadBasket
  attr_reader :basket, :file
  def initialize(basket, file)
    @basket = basket
    @file = file
    parse_file_to_basket
  end

  def parse_file_to_basket
    gst = Tax.new("GST",10)
    import = Tax.new("import",5)

    table = CSV.parse(File.read(file), headers: true)
    table.each do |row|
      qty = row["Quantity"].to_i
      name = row["Product"].split(" ")
      price = row["Price"].to_f
      imported = false
      imported = true if name.delete('imported')
      name = name.join(' ')
      taxes = []
      taxes << gst if INVENTORY[name]
      taxes << import if imported

      item = Item.new(qty: qty, name: name, price: price, imported: imported, taxes: taxes)
      basket.add(item)
    end
  end
end