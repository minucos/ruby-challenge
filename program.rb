require_relative "./lib/basket"

puts "Calculating Test Input 1\n"
b1 = Basket.new

File.open("input_1.txt","r") do |f|
  f.each_line do |line|
    b1.add(line)
  end
end

b1.print_receipt

puts "\n\nCalculating Test Input 2\n"
b2 = Basket.new

File.open("input_2.txt","r") do |f|
  f.each_line do |line|
    b2.add(line)
  end
end

b2.print_receipt

puts "\n\nCalculating Test Input 3\n"
b3 = Basket.new

File.open("input_3.txt","r") do |f|
  f.each_line do |line|
    b3.add(line)
  end
end

b3.print_receipt