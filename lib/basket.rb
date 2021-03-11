require_relative 'inventory'

class Basket
  attr_reader :items
  def initialize
    @items = []
  end

  def add(line)
    item = line.split(', ')
    qty = item[0].to_i
    name = item[1].split(' ')
    price = item[2].to_f
    imported = false
    imported = true if name.delete('imported')
    items << [qty, name.join(' '), price, imported]
  end

  def calc_item_tax(price,tax_rate)
    tax = price * tax_rate / 100

    return (tax * 20).round / 20.0
  end

  def calc_tax_rate(name,imported)
    rate = INVENTORY[name]
    rate += 5 if imported
    return rate
  end

  def calc_basket_tax
    total_tax = 0

    items.each do |item|
      tax_rate = calc_tax_rate(item[1],item[-1])
      item_tax = calc_item_tax(item[-2],tax_rate)
      total_tax += item_tax * item[0]
    end

    return total_tax
  end

  def calc_basket_total
    total = 0

    items.each do |item|
      tax_rate = calc_tax_rate(item[1],item[-1])
      item_tax = calc_item_tax(item[-2],tax_rate)
      total += (item[-2] + item_tax) * item[0]
    end

    return total.round(2)
  end

  def print_receipt
    items.each do |item|
      puts item[0..-2].join(", ")
    end
    puts ""
    puts "Sales Taxes: #{calc_basket_tax}"
    puts "Total: "
  end
end