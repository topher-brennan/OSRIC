require './osric_support'

class OsricGem
  include OsricSupport

  attr_accessor :value_in_cp

  def initialize
    category = roll_category
    has_increased_category = false
    has_decreased_category = false

    d10_roll = rand(10) + 1
    
    while ((d10_roll == 1 && !has_decreased_category) || (d10_roll == 10 && !has_increased_category)) && category != 1 && category != 18
      case d10_roll
      when 1
        category += 1
      when 10
        category -= 1
      end
      d10_roll = rand(10) + 1
    end
    
    if d10_roll == 2
      @value_in_cp = roll_value(category) * 2
    elsif d10_roll ==  3
      @value_in_cp = roll_value(category) * 3
    elsif d10_roll == 9 && !has_increased_category
      @value_in_cp = roll_value(category) * (9 - rand(3)) / 10
    else
      @value_in_cp = roll_value(category)
    end
  end

  def roll_category
    case rand(100)
    when 0
      return 11
    when (1..30)
      return 6
    when (31..55)
      return 7
    when (56..75)
      return 8
    when (76..90)
      return 9
    when (91..99)
      return 10
    end
  end

  def roll_value(category)
    case category
    when (1..12)
      value = nil
      if category % 2 == 1
        value = roll('4d4')
      else
        value = roll('2d4')
      end
      value *= 10 ** (category / 2)
      return value
    when 13
      return roll('2d4') * 500_000
    when 14
      return roll('2d4') * 1_000_000
    when 15
      return roll('4d4') * 1_000_000
    when 16
      return roll('2d4') * 5_000_000
    when 17
      return roll('2d4') * 10_000_000
    when 18
      return roll('4d4') * 10_000_000
    else
      raise ArgumentError 'category must be between 1 and 18'
    end
  end

  def xp_reward
    @value_in_cp / 100
  end
end
