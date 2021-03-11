require "tax"

describe Tax do
  subject(:tax) { Tax.new('GST', 10)}
  describe "#initialize" do
    it "has a category instance variable" do
      expect(tax.category).to eq('GST')
    end
    it "has a rate instance variable" do
      expect(tax.rate).to eq(10)
    end
  end
end