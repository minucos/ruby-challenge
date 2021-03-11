require "item"

describe Item do
  subject(:item) { Item.new(name: 'book', price: 10, categories: ['books'])}
  describe "#initialize" do
    it "sets a name instance variable" do
      expect(item.name).to eq('book')
    end
    it "sets a price instance variable" do
      expect(item.price).to eq(10)
    end
  end 
end