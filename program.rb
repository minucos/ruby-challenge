require 'byebug'
require_relative "./lib/basket"
require_relative "./lib/load_basket"


puts "\nTest Output 1\n"
b1 = Basket.new
lb = LoadBasket.new(b1,File.new("./input_1.csv"))

b1.print_receipt

puts "\nTest Output 2\n"
b2 = Basket.new
lb = LoadBasket.new(b2,File.new("./input_2.csv"))

b2.print_receipt

puts "\nTest Output 3\n"
b3 = Basket.new
lb = LoadBasket.new(b3,File.new("./input_3.csv"))

b3.print_receipt