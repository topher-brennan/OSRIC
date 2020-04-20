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
	reward = monster.xp_reward
        if @pc.strength > 15
	  reward *= 11
	  reward /= 10
        end
        @pc.xp += reward
      else
        @alive = false
      end
    end

    @pc.level_up if @alive

    while @pc.xp < 4250 && @alive
      @pc.full_heal
      monster = Goblin.new

      if Battle.new(@pc, monster).player_character_wins?
        @wins += 1
        reward = monster.xp_reward
        if @pc.strength > 15
          reward *= 11
          reward /= 10
        end
        @pc.xp += reward
      else
        @alive = false
      end
    end

    @pc.level_up if @alive

    # puts "Sir Bob acquired #{@pc.xp} experience points before #{@alive ? 'reaching 3rd level' : 'dying'}"
    # puts "Sir Bob's stats: #{@pc.stat_block}"
  end
end

if $PROGRAM_NAME == __FILE__
  results = Array.new(4) { 0 }
  100_000.times do
    pc = Fighter.new
    Tale.new(pc).tell
    results[pc.level] += 1
  end
  puts results
end
