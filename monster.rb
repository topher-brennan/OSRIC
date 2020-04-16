class Monster
  def initialize
    @max_hp = roll_hp
    @hp = @max_hp
  end

  def roll_hp
    (1..hit_dice.first).map { rand(8) + 1 }.inject(:+) + hit_dice.last
  end

  def hit_dice
    raise NotImplementedError
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

  # TODO: This entire implementation is hacky, if I had a lot of sub 1-1 HD monsters I should write up a more general solution.
  def roll_hp
    rand(4)+1
  end

  def equivalent_level
    0
  end
end

class Goblin < Monster
  ARMOR_CLASS = 6

  def hit_dice
    [1, -1]
  end
end

class Orc < Monster
  ARMOR_CLASS = 6

  def hit_dice
    [1, 0]
  end
end

class Hobgoblin < Monster
  ARMOR_CLASS = 5

  def hit_dice
    [1, 1]
  end
end

class Gnoll < Monster
  ARMOR_CLASS = 5

  def hit_dice
    [2, 0]
  end
end

class Bugbear < Monster
  ARMOR_CLASS = 5

  def hit_dice
    [3, 1]
  end
end

class Ogre < Monster
  ARMOR_CLASS = 5

  def hit_dice
    [4, 1]
  end
end

class Owlbear < Monster
  ARMOR_CLASS = 6

  def hit_dice
    [5, 1]
  end
end
