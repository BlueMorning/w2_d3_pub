class Customer

  attr_reader :name, :wallet

  def initialize(name, wallet)
    @name   = name
    @wallet = wallet
  end

def can_aford_drink(drink)
    return @wallet >= drink.price 
end



end
