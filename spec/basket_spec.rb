require "byebug"
require "basket"
require "item"
require "tax"

describe Basket do
  subject(:basket) { Basket.new }
  let(:gst) { Tax.new("GST",10)}
  let(:import) { Tax.new("import",5)}
  let(:item) { Item.new(qty: 1, name: 'Music CD', price: 10, taxes: [gst, import], imported: true)}
  let(:item_2) { Item.new(qty: 1, name: 'book', price: 5, taxes: [], imported: false)}
  let(:item_3) { Item.new(qty: 1, name: 'headache pills', price: 15, taxes: [import], imported: true)}
  
  describe "#initalize" do
    it "initalizes with an empty items array" do
      expect(basket.items).to eq([])
    end
  end

  describe "#add" do
    it "takes a string as argument, and adds item to items array" do
      basket.add(item)

      expect(basket.items).to include(item)
    end
  end

  describe "calc_basket_tax" do
    it "calculates the total tax for all items in basket" do
      basket.add(item)
      basket.add(item_2)
      basket.add(item_3)
      basket_tax = basket.calc_basket_tax

      expect(basket_tax).to eq(2.25)
    end
  end

  describe "calc_basket_total" do
    it "calculates the total cost of all items in basket" do
      basket.add(item)
      basket.add(item_2)
      basket.add(item_3)
      basket_total = basket.calc_basket_total

      expect(basket_total).to eq(32.25)
    end
  end

  describe "#receipt_tax" do
  it "returns the total tax as a string to 2 decimal places for receipt" do
      basket.add(item)
      basket.add(item_2)
      basket.add(item_3)
      expect(basket.receipt_tax).to eq("2.25")
    end
  end
  
  describe "#receipt_total" do
  it "returns the total price as a string to 2 decimal places for receipt" do
      basket.add(item)
      basket.add(item_2)
      basket.add(item_3)
      expect(basket.receipt_total).to eq("32.25")
    end
  end

  describe "Basket#print_receipt" do
    let(:basket_1) { Basket.new }
    let(:basket_2) { Basket.new }
    let(:basket_3) { Basket.new }
    
    it "outputs a receipt for all items" do
      # setting up basket_1
      basket_1.add(
        Item.new(
          qty: 1, 
          name: 'book', 
          price: 12.49,
          taxes: [], 
          imported: false
        )
      )
      basket_1.add(
        Item.new(
          qty: 1, 
          name: 'music CD', 
          price: 14.99,
          taxes: [gst], 
          imported: false
        )
      )
      basket_1.add(
        Item.new(
          qty: 1, 
          name: 'chocolate bar', 
          price: 0.85,
          taxes: [], 
          imported: false
        )
      )
      # setting up basket_2
      basket_2.add(
        Item.new(
          qty: 1, 
          name: 'box of chocolates', 
          price: 10,
          taxes: [import], 
          imported: true
        )
      )
      basket_2.add(
        Item.new(
          qty: 1, 
          name: 'bottle of perfume', 
          price: 47.50,
          taxes: [gst,import], 
          imported: true
        )
      )
      
      # setting up basket_3
      basket_3.add(
        Item.new(
          qty: 1, 
          name: 'bottle of perfume', 
          price: 27.99,
          taxes: [gst,import], 
          imported: true
        )
      )
      basket_3.add(
        Item.new(
          qty: 1, 
          name: 'bottle of perfume', 
          price: 18.99,
          taxes: [gst], 
          imported: false
        )
      )
      basket_3.add(
        Item.new(
          qty: 1, 
          name: 'packet of headache pills', 
          price: 9.75,
          taxes: [], 
          imported: false
        )
      )
      basket_3.add(
        Item.new(
          qty: 1, 
          name: 'box of chocolates', 
          price: 11.25,
          taxes: [import], 
          imported: true
        )
      )

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