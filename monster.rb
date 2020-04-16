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
end

# Listed in rough order of power level, which will be used in my first pass simulation of raising a PC from level 1 to level 9.

class Kobold < Monster
  def roll_hp
    rand(4)+1
  end
end

class Goblin < Monster
  def hit_dice
    [1, -1]
  end
end

class Orc < Monster
  def hit_dice
    [1, 0]
  end
end

class Hobgoblin < Monster
  def hit_dice
    [1, 1]
  end
end

class LizardMan < Monster
  def hit_dice
    [2, 1]
  end
end

class Bugbear < Monster
  def hit_dice
    [3, 1]
  end
end

class Ogre < Monster
  def hit_dice
    [4, 1]
  end
end

class Owlbear < Monster
  def hit_dice
    [5, 1]
  end
end
