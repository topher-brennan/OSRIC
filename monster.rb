require './osric_support.rb'

class Monster
  def initialize
    @max_hp = roll_hp
    @hp = @max_hp
  end

  def roll_hp
    [OsricSupport.roll(self.class::HIT_DICE), 1].max
  end

  # TODO: Handle monsters with HD less than 1-1
  def equivalent_level
    if hit_dice.last < 0
      return 1
    else
      return hit_dice.first + 1 + (hit_dice.last > 0 ? 1 : 0)
    end
  end

  def to_hit(armor_class)
    result = 21 - armor_class - [equivqlent_level, 20].min
    result -= 5 if result > 20
    result
  end

  def armor_class
    self::ARMOR_CLASS
  end
end

# Listed in rough order of power level, which will be used in my first pass simulation of raising a PC from level 1 to level 9.

class Kobold < Monster
  ARMOR_CLASS = 7
  HIT_DICE = '1d4'

  # Hacky, should be fixed when I implement more sub HD 1-1 monsters.
  def equivalent_level
    0
  end
end

class Goblin < Monster
  ARMOR_CLASS = 6
  HIT_DICE = '1-1'
end

class Orc < Monster
  ARMOR_CLASS = 6
  HIT_DICE = '1'
end

class Hobgoblin < Monster
  ARMOR_CLASS = 5
  HIT_DICE = '1+1'
end

class Gnoll < Monster
  ARMOR_CLASS = 5
  HIT_DICE = '2'
end

class Bugbear < Monster
  ARMOR_CLASS = 5
  HIT_DICE = '3+1'
end

class Ogre < Monster
  ARMOR_CLASS = 5
  HIT_DICE = '4+1'
end

class Owlbear < Monster
  ARMOR_CLASS = 6
  HIT_DICE = '5+1'
end
