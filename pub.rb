#require_relative()

class Pub

  attr_reader :name, :drinks, :food, :till, :legal_age, :max_drunkenness_level

  def initialize(name, drinks, food = [], legal_age = 18, max_drunkenness_level = 10)
    @name                   = name
    @drinks                 = drinks
    @food                   = food
    @till                   = 0
    @legal_age              = legal_age
    @max_drunkenness_level  = max_drunkenness_level
  end

  def is_food_available?(food)
    return @food[food.name] != nil && @food[food.name][:quantity] > 0
  end

  def is_drink_available?(drink)
    return @drinks[drink.name] != nil && @drinks[drink.name][:quantity] > 0
  end

  def yield_drink(drink)
    @drinks[drink.name][:quantity] -= 1
  end

  def yield_food(food)
    @food[food.name][:quantity] -= 1
  end

  def increase_till(price)
    return @till += price
  end

  def serve_drink(customer, drink)
    return if !(is_customer_above_legal_age?(customer))
    return if !(is_drink_available?(drink))
    return if !(customer.can_afford_item?(drink.price))
    yield_drink(drink)
    customer.decrease_wallet(drink.price)
    increase_till(drink.price)
    customer.increase_drunkenness_level(drink)
  end

  def serve_food(customer, food)
    return if !(is_food_available?(food))
    return if !(customer.can_afford_item?(food.price))
    yield_food(food)
    customer.decrease_wallet(food.price)
    increase_till(food.price)
    customer.decrease_drunkenness_level(food)
  end

  def is_customer_above_legal_age?(customer)
    return customer.age >= @legal_age
  end

  def is_customer_drunkenness_level_above_max?(customer)
    return customer.drunkenness_level >= @max_drunkenness_level
  end

  def stock_value()
    stock_value = 0
    @drinks.each do |drink_name, drink_info|
      stock_value += (drink_info[:drink].price * drink_info[:quantity])
    end
    return stock_value
  end

end
