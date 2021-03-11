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
    it "calculates the tax for item" do
      item_tax = basket.calc_item_tax(50,10)

      expect(item_tax).to be(5.00)
    end
  end
end