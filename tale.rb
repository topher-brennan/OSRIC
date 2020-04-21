require './battle.rb'
require './fighter.rb'
require './monster.rb'

class Tale
  MAX_LEVEL = 6

  def initialize(player_character)
    @player_character = player_character
    @alive = true
  end

  def tell
    while @player_character.level < MAX_LEVEL && @alive
      @player_character.full_heal
      monster = Monster.for_level(@player_character.level)

      unless Battle.new(@player_character, monster).player_character_wins?
        @alive = false
      end

      @player_character.level_up_if_necessary if @alive
    end

  end
end

if $PROGRAM_NAME == __FILE__
  total_str = 0
  total_dex = 0
  total_con = 0
  total_int = 0
  total_wis = 0
  total_cha = 0

  2000.times do
    pc = Fighter.new
    Tale.new(pc).tell

    while pc.level <= 5
      pc = Fighter.new
      Tale.new(pc).tell
    end
  
    total_str += pc.strength
    total_dex += pc.dexterity
    total_con += pc.constitution
    total_int += pc.intelligence
    total_wis += pc.wisdom
    total_cha += pc.charisma
  end

  puts total_str / 2000.0
  puts total_dex / 2000.0
  puts total_con / 2000.0
  puts total_int / 2000.0
  puts total_wis / 2000.0
  puts total_cha / 2000.0
end
