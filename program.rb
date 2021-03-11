require_relative "./lib/basket"

b = Basket.new

File.open("input_2.txt","r") do |f|
  f.each_line do |line|
    b.add(line)
  end
end

b.print_receipt