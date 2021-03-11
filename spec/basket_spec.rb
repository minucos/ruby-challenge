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

      expect(basket.items).to include([1, 'book', 12.49, false])
    end
    it "sets imported property to true if included in string" do
      basket.add('1, imported chocolates, 5')
      
      expect(basket.items).to include([1, 'chocolates', 5.0, true])
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

  describe "calc_basket_tax" do
    it "calculates the total tax for all items in basket" do
      basket.add('1, book, 12.49')
      basket.add('1, music cd, 14.99')
      basket.add('1, chocolate bar, 0.85')
      basket_tax = basket.calc_basket_tax

      expect(basket_tax).to eq(1.50)
    end
  end

  describe "calc_basket_total" do
    it "calculates the total cost of all items in basket" do
      basket.add('1, book, 12.49')
      basket.add('1, music cd, 14.99')
      basket.add('1, chocolate bar, 0.85')
      basket_total = basket.calc_basket_total

      expect(basket_total).to eq(29.83)
    end
  end

  describe "Basket#print_receipt" do
    let(:basket_1) { Basket.new }
    let(:basket_2) { Basket.new }
    let(:basket_3) { Basket.new }
    
    it "outputs a receipt for all items" do
      # setting up basket_1
      basket_1.add('1, book, 12.49')
      basket_1.add('1, music cd, 14.99')
      basket_1.add('1, chocolate bar, 0.85')
      # setting up basket_2
      basket_2.add('1, imported box of chocolates, 10.00')
      basket_2.add('1, imported bottle of perfume, 47.50')
      # setting up basket_3
      basket_3.add('1, imported bottle of perfume, 27.99')
      basket_3.add('1, bottle of perfume, 18.99')
      basket_3.add('1, packet of headache pills, 9.75')
      basket_3.add('1, box of imported chocolates, 11.25')

      expect do basket_1.print_receipt
      end.to output('1, book, 12.49\n1, music CD, 16.49\n1, chocolate bar, 0.85\n\nSales Taxes: 1.50\nTotal: 29.83')
      .to_stdout
    end
  end
end