require_relative "inventory"

class Basket
  attr_reader :items
  def initialize()
    @items = []
  end

  def add(item)
    @items << item
  end

  def calc_basket_tax
    total_tax = 0

    items.each do |item|
      total_tax += item.tax
    end

    return total_tax
  end

  def calc_basket_total
    total = 0

    items.each do |item|
      total += item.inc_price
    end

    return total
  end

  def receipt_tax
    return "%.2f" % calc_basket_tax
  end

  def receipt_total
    return "%.2f" % calc_basket_total
  end

  def print_receipt
    items.each do |item|
      puts item
    end
    puts ""
    puts "Sales Taxes: #{receipt_tax}"
    puts "Total: #{receipt_total}"
  end
end