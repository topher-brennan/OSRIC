require './osric_support'

class Fighter
  include OsricSupport

  attr_accessor :hp, :xp, :strength

  # Shield and banded armour
  ARMOR_CLASS = 3

  def initialize
    roll_ability_scores
    while @strength < 9 || @dexterity < 6 || @constitution < 7 || @wisdom < 6 || @charisma < 6 
      roll_ability_scores
    end

    @level = 1
    @xp = 0

    @max_hp = roll('1d10')
    @max_hp += (@constitution - 14) if @constitution > 14
    @hp = @max_hp  
  end

  def ability_score_block
    "STR #{@strength} DEX #{@dexterity} CON #{@constitution} INT #{@intelligence} WIS #{@wisdom} CHA #{@charisma}"
  end

  # TODO: Decimal strength
  def roll_ability_scores
    @strength, @dexterity, @constitution, @intelligence, @wisdom, @charisma = Array.new(6) { roll('3d6') }
  end

  # TODO: DRY out this and the corresponding function in Monster
  def to_hit(armor_class)
    result = 21 - armor_class - [@level, 20].min
    result -= 5 if result > 20
    # Maybe refactor this, it's potentially confusing.
    result -= 1 if @strength > 16
    result
  end

  # TODO: This should take the target's size as an argument
  def roll_damage
    # Broadsword
    rolled = roll('2d4')
    if @strength > 17
      return rolled + 2
    elsif @strength > 15
      return rolled + 1
    else
      return rolled
    end
  end

  def armor_class
  # TODO: calculate this based on gold?
    result = self.class::ARMOR_CLASS
    result += (7 - @dexterity) if @dexterity < 7
    result += (14 - @dexterity) if @dexterity > 14
    result
  end

  def full_heal
    @hp = @max_hp
  end
end
