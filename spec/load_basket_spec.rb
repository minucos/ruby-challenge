require "load_basket"
require "basket"

describe LoadBasket do
  let(:basket) { Basket.new }
  let(:file) { File.new("input_1.csv") }
  subject(:load_basket) { LoadBasket.new(basket, file) }
  describe "#initialize" do
    it "initalizes with a basket instance variable" do
      expect(load_basket.basket.class).to eq(Basket)
    end
    it "initalizes with a file instance variable" do
      expect(load_basket.file.class).to eq(File)
    end
  end

  describe "#parse_file_to_basket" do
    it "reads the given file and adds items to the basket" do
      expect(load_basket.basket.items.count).to be(3)
    end
  end
end