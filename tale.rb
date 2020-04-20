require './battle.rb'
require './fighter.rb'
require './monster.rb'

class Tale
  def initialize(pc)
    @pc = pc
    @alive = true
    @wins = 0
  end

  def tell
    while @pc.xp < 1_900 && @alive
      @pc.full_heal
      monster = Kobold.new

      if Battle.new(@pc, monster).player_character_wins?
        @wins += 1
        @pc.xp += monster.xp_reward
      else
        @alive = false
      end
    end
    puts "Sir Bob defeated #{@wins} kobolds and acquired #{@pc.xp} experience points before #{@alive ? 'reaching 2nd level' : 'dying'}"
    puts "Sir Bob's stats: #{@pc.ability_score_block}"
  end
end

if $PROGRAM_NAME == __FILE__
  Tale.new(Fighter.new).tell
end
