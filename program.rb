require "csv"
require "byebug"
require_relative "./lib/basket"
require_relative "./lib/item"
require_relative "./lib/tax"
require_relative "./lib/inventory"


puts "Calculating Test Input 1\n"
b1 = Basket.new
gst = Tax.new("GST",10)
import = Tax.new("import",5)

table = CSV.parse(File.read("input_2.csv"), headers: true)

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
  b1.items << item
end

b1.print_receipt

# puts "\n\nCalculating Test Input 2\n"
# b2 = Basket.new

# File.open("input_2.txt","r") do |f|
#   f.each_line do |line|
#     b2.add(line)
#   end
# end

# b2.print_receipt

# puts "\n\nCalculating Test Input 3\n"
# b3 = Basket.new

# File.open("input_3.txt","r") do |f|
#   f.each_line do |line|
#     b3.add(line)
#   end
# end

# b3.print_receipt