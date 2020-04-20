require './battle.rb'
require './fighter.rb'
require './monster.rb'

class Tale
  def initialize(player_character)
    @player_character = player_character
    @alive = true
  end

  def tell
    while @player_character.xp < 1_900 && @alive
      @player_character.full_heal
      monster = Monster.for_level(@player_character.level)

      unless Battle.new(@player_character, monster).player_character_wins?
        @alive = false
      end
    end

    @player_character.level_up if @alive

    while @player_character.xp < 4250 && @alive
      @player_character.full_heal
      monster = Monster.for_level(@player_character.level)

      unless Battle.new(@player_character, monster).player_character_wins?
        @alive = false
      end
    end

    @player_character.level_up if @alive

    # puts "Sir Bob acquired #{@player_character.xp} experience points before #{@alive ? 'reaching 3rd level' : 'dying'}"
    # puts "Sir Bob's stats: #{@player_character.stat_block}"
  end
end

if $PROGRAM_NAME == __FILE__
  TRIALS = 250

  results = Array.new(4) { 0 }
  TRIALS.times do
    pc = Fighter.new
    Tale.new(pc).tell
    results[pc.level] += 1
  end
  puts results.map { |r| r.to_f / TRIALS }
end
