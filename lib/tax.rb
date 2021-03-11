class Tax 
  attr_reader :category, :rate
  def initialize(category, rate)
    @category = category
    @rate = rate
  end
end