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
    items << [qty, name.join(' '), price, imported: imported]
  end
end