require './osric_gem.rb'
require './osric_support.rb'

class Monster
  include OsricSupport

  attr_accessor :hp

  def initialize
    @max_hp = roll_hp
    @hp = @max_hp
  end

  def roll_hp
    [roll(self.class::HIT_DICE), 1].max
  end

  # TODO: Handle monsters with HD less than 1-1
  def equivalent_level
    parsed_hd = parse_dice(self.class::HIT_DICE)
 
    if parsed_hd[-2] == '-'
      return 1
    else
      return parsed_hd.first + 1 + (parsed_hd.size > 3 ? 1 : 0)
    end
  end

  def to_hit(armor_class)
    result = 21 - armor_class - [equivalent_level, 20].min
    result -= 5 if result > 20
    result
  end

  def roll_damage
    roll(self.class::DAMAGE)
  end

  def armor_class
    self.class::ARMOR_CLASS
  end
end

# Listed in rough order of power level, which will be used in my first pass simulation of raising a PC from level 1 to level 9.

class Kobold < Monster
  ARMOR_CLASS = 7
  HIT_DICE = '1d4'
  DAMAGE = '1d4'

  # TODO: Hacky, should be fixed when I implement more sub HD 1-1 monsters.
  def equivalent_level
    0
  end

  def xp_reward
    result = 5 + @max_hp
    # Copper
    result += 1 if rand(8) == 0
    # Silver
    result += [2, 5, 7].sample if rand(10) < 3
    # Gems. Note statistically 1 in 320 Kobolds has a gem but I'm assuming risk and reward is polled over 4 party members
    result += OsricGem.new.xp_reward / 4 if rand(80) == 0
    result
  end
end

class Goblin < Monster
  ARMOR_CLASS = 6
  HIT_DICE = '1-1'
  DAMAGE = '1d6'
end

class Orc < Monster
  ARMOR_CLASS = 6
  HIT_DICE = '1'
  DAMAGE = '1d8'
end

class Hobgoblin < Monster
  ARMOR_CLASS = 5
  HIT_DICE = '1+1'
  DAMAGE = '1d8'
end

class Gnoll < Monster
  ARMOR_CLASS = 5
  HIT_DICE = '2'
  DAMAGE = '2d4'
end

class Bugbear < Monster
  ARMOR_CLASS = 5
  HIT_DICE = '3+1'
  DAMGE = '2d4'
end

class Ogre < Monster
  ARMOR_CLASS = 5
  HIT_DICE = '4+1'
  DAMAGE = '1d10'
end

# TODO: Rethink how multiple attacks are represented
# class Owlbear < Monster
#  ARMOR_CLASS = 6
#  HIT_DICE = '5+1'
#  DAMAGE = ['1d6', '1d6', '1d4']
#end
