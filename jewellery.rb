require './osric_support'

class Jewellery
  include OsricSupport

  attr_reader :xp_reward
  
  def initialize
    # These probabilities were derived from the table in OSRIC pp. 322-323 with
    # help from a spreadsheet
    case rand(1000)
    when (1..318)
      @xp_reward = roll('1d10') * 100
    when (319..594)
      @xp_reward = roll('2d6') * 100
    when (594..799)
      @xp_reward = roll('3d6') * 100
    when (800..916)
      @xp_reward = roll('5d6') * 100
    when (917..991)
      @xp_reward = roll('2d4') * 1_000
    else
      @xp_reward = roll('2d6') * 1_000
    end
  end
end
