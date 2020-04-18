require './osric_support'

class Fighter
  include OsricSupport

  attr_accessor :hp

  # Shield and banded armour
  ARMOR_CLASS = 3

  def initialize
    @level = 1
    @max_hp = roll('1d10')
    
    @strength, @dexterity, @constitution, @intelligence, @wisdom, @charisma = Array.new(6) { roll('3d6') }

    # TODO: CON modifiers to HP
    @hp = @max_hp
  end

  # TODO: DRY out this and the corresponding function in Monster
  def to_hit(armor_class)
    result = 21 - armor_class - [@level, 20].min
    result -= 5 if result > 20
    result
  end

  # TODO: This should take the target's size as an argument
  # TODO: Include strength modifiers
  def roll_damage
    # Longsword
    roll('1d8')
  end

  # TODO: Factor in Dexterity
  def armor_class
  # TODO: calculate this based on gold?
    self.class::ARMOR_CLASS
  end
end
