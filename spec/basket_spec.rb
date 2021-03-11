require 'basket'
require 'byebug'

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
      item_tax = basket.calc_item_tax(10,5)
      item_tax2 = basket.calc_item_tax(12.7,10)
      
      expect(item_tax).to eq(0.5)
      expect(item_tax2).to eq(1.30)
    end
  end

  describe "#calc_total_item_cost" do
    it "calculates the total item cost including tax for a given item" do
      item_1 = [1, 'book', 12.49, false]
      item_2 = [1, 'chocolate bar', 10, true]
      total_item_cost_1 = basket.calc_total_item_cost(item_1)
      total_item_cost_2 = basket.calc_total_item_cost(item_2)
      
      expect(total_item_cost_1).to eq(12.49)
      expect(total_item_cost_2).to eq(10.50)
    end
  end

  describe "#calc_tax_rate" do
    it "calculates the tax rate on an item" do
      tax_rate1 = basket.calc_tax_rate('book',false)
      tax_rate2 = basket.calc_tax_rate('music CD',false)
      tax_rate3 = basket.calc_tax_rate('bottle of perfume',true)
      tax_rate4 = basket.calc_tax_rate('packet of headache pills',true)

      expect(tax_rate1).to be(0)
      expect(tax_rate2).to be(10)
      expect(tax_rate3).to be(15)
      expect(tax_rate4).to be(5)
    end
  end

  describe "calc_basket_tax" do
    it "calculates the total tax for all items in basket" do
      basket.add('1, book, 12.49')
      basket.add('1, music CD, 14.99')
      basket.add('1, chocolate bar, 0.85')
      basket_tax = basket.calc_basket_tax

      expect(basket_tax).to eq(1.50)
    end
  end

  describe "calc_basket_total" do
    it "calculates the total cost of all items in basket" do
      basket.add('1, book, 12.49')
      basket.add('1, music CD, 14.99')
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
      basket_1.add('1, music CD, 14.99')
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
      end.to output(
      "1, book, 12.49\n1, music CD, 16.49\n1, chocolate bar, 0.85\n\nSales Taxes: 1.50\nTotal: 29.83\n"
      )
      .to_stdout
      expect do basket_2.print_receipt
      end.to output(
      "1, imported box of chocolates, 10.50\n1, imported bottle of perfume, 54.65\n\nSales Taxes: 7.65\nTotal: 65.15\n"
      )
      .to_stdout
      expect do basket_3.print_receipt
      end.to output(
      "1, imported bottle of perfume, 32.19\n1, bottle of perfume, 20.89\n1, packet of headache pills, 9.75\n1, imported box of chocolates, 11.85\n\nSales Taxes: 6.70\nTotal: 74.68\n"
      )
      .to_stdout
    end
  end
end