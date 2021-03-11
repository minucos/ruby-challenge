require "item"
require "tax"

describe Item do
  let(:gst) { Tax.new("GST",10)}
  let(:import) { Tax.new("import",5)}
  subject(:item) { Item.new(qty: 1, name: 'Music CD', price: 10, taxes: [gst, import], imported: true)}
  describe "#initialize" do
    it "sets a quantity instance variable" do
      expect(item.qty).to eq(1)
    end
    it "sets a name instance variable" do
      expect(item.name).to eq('Music CD')
    end
    it "sets a price instance variable" do
      expect(item.price).to eq(10)
    end
    it "sets a taxes instance variable" do
      expect(item.taxes).to eq([gst,import])
    end
    it "sets an imported instance variable" do
      expect(item.imported).to be true
    end
  end 

  describe "#tax_rate" do
    it "returns the total tax rate for this item" do
      expect(item.tax_rate).to be(15)
    end
  end
  
  describe "#tax" do
    it "returns the total tax for this item" do
      expect(item.tax).to eq(1.50)
    end
  end

  describe "#inc_price" do
    it "returns the total price including all taxes" do
      expect(item.inc_price).to eq(11.50)
    end
  end

  describe "#receipt_name" do
    it "returns the full name of item for receipt" do
      expect(item.receipt_name).to eq("imported Music CD")
    end
  end

  describe "#receipt_price" do
    it "returns the inc price as a string to 2 decimal places for receipt" do
      expect(item.receipt_name).to eq("imported Music CD")
    end
  end

  describe "#to_s" do
    it "returns a string of the item in correct format" do
      expect(item.to_s).to eq("1, imported Music CD, 11.50")
    end
  end

end