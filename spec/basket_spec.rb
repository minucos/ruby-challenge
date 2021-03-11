require 'basket'

describe Basket do
  subject(:basket) { Basket.new }
  describe "#initalize" do
    it "initalizes with an empty items array" do
      expect(basket.items).to eq([])
    end
  end

  describe "#add" do
    it "takes a string as argument, and adds item to items array" do
      basket.add('1, book, 12.49')

      expect(basket.items).to include([1, 'book', 12.49, imported: false])
    end
    it "sets imported property to true if included in string" do
      basket.add('1, imported chocolates, 5')
      
      expect(basket.items).to include([1, 'chocolates', 5.0, imported: true])
    end
  end

  describe "#calc_item_tax" do
    it "takes a price and tax rate as arguments" do
      expect { basket.calc_item_tax(50,10) }.not_to raise_error
      expect { basket.calc_item_tax(50) }.to raise_error(ArgumentError)
    end
    it "calculates the tax for item rounded to the nearest 0.05" do
      item_tax = basket.calc_item_tax(50,10)
      item_tax2 = basket.calc_item_tax(12.7,10)
      
      expect(item_tax).to eq(5.00)
      expect(item_tax2).to eq(1.25)
    end
  end

  describe "#calc_tax_rate" do
    it "calculates the tax rate on an item" do
      tax_rate1 = basket.calc_tax_rate('book',false)
      tax_rate2 = basket.calc_tax_rate('music cd',false)
      tax_rate3 = basket.calc_tax_rate('bottle of perfume',true)
      tax_rate4 = basket.calc_tax_rate('headache pills',true)

      expect(tax_rate1).to be(0)
      expect(tax_rate2).to be(10)
      expect(tax_rate3).to be(15)
      expect(tax_rate4).to be(5)
    end
  end
end