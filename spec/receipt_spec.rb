require "receipt"
require "basket"
require "item"
require "tax"

describe Receipt do
  let(:basket) { Basket.new }
  let(:gst) { Tax.new("GST",10)}
  let(:import) { Tax.new("import",5)}
  let(:item_1) { Item.new(qty: 1, name: "book", price: 12.49,taxes: [], imported: false) }
  let(:item_2) { Item.new(qty: 1, name: "music CD", price: 14.99,taxes: [gst], imported: false) }
  let(:item_3) { Item.new(qty: 1, name: "chocolate bar", price: 0.85,taxes: [], imported: false) }
  
  before(:each) do
    basket.add(item_1)
    basket.add(item_2)
    basket.add(item_3)
  end

  subject(:receipt) { Receipt.new(basket) }

  describe "#initialize" do
    it "sets a basket instance variable" do
      expect(receipt.basket).to be(basket)
    end
  end

  describe "#to_s" do
    it "outputs a receipt for all items" do
      expect(receipt.to_s).to eq(
        "1, book, 12.49\n1, music CD, 16.49\n1, chocolate bar, 0.85\n\nSales Taxes: 1.50\nTotal: 29.83\n"
      )
    end
  end
end