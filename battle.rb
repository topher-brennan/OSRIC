require './fighter.rb'
require './monster.rb'
require './osric_support.rb'

class Battle
  include OsricSupport

  def initialize(player_character, monster)
    @player_character = player_character
    @monster = monster
  end

  def player_character_wins?
    # This assumes a fighter against a monster with only one attack.
    if @player_character.level == 0
      pc_initiative = roll('1d6')
      monster_initiative = roll('1d6')
   
      # Ties effectively go to the monster, because if the PC dies we don't care if the monster does too.
      if pc_initiative > monster_initiative
        resolve_attack(@player_character, @monster)
      end

      while @player_character.hp > 0 && @monster.hp > 0
        resolve_attack(@monster, @player_character)

        if @player_character.hp > 0
          resolve_attack(@player_character, @monster)
        end
      end
    else
      while @player_character.hp > 0 && @monster.hp > 0
        resolve_attack(@player_character, @monster)

        if @monster.hp > 0
          resolve_attack(@monster, @player_character)
        end

	(@player_character.level - 1).times do
	  resolve_attack(@player_character, @monster)
	end
      end
    end

    assign_rewards if @player_character.hp > 0
    @player_character.hp > 0
  end

  def resolve_attack(attacker, target)
    if roll('1d20') >= attacker.to_hit(target.armor_class)
      target.hp -= attacker.roll_damage
    end
  end

  def assign_rewards
    reward = @monster.xp_reward
    if @player_character.strength > 15
      reward *= 11
      reward /= 10
    end
    @player_character.xp += reward  
  end
end
