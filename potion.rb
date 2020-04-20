class Potion
  def initialize
    case rand(10_000)
    when (0...250)
      @gp_value = 0
    when (2_50...5_00)
      @gp_value = 150
    when (5_00...10_00)
      @gp_value = 250
    when (10_00...20_75)
      @gp_value = 300
    when (20_75...22_50)
      @gp_value = 350
    when (22_50...40_75)
      @gp_value = 400
    when (40_75...43_25)
      @gp_value = 450
    when (43_25...59_00)
      @gp_value = 500
    when (59_00...66_50)
      @gp_value = 750
    when (66_50...68_25)
      @gp_value = 800
    when (68_25...75_75)
      @gp_value = 900
    when (75_75...83_25)
      @gp_value = 900
    when (83_25...85_75)
      @gp_value = 1000
    when (85_75...88_25)
      @gp_value = 1500
    when (88_25...92_00)
      @gp_value = 2000
    when (92_00...93_25)
      @gp_value = 2500
    when (93_25...95_00)
      @gp_value = roll_dragon_control
    when (95_00...97_50)
      @gp_value = roll_giant_control
    else
      @gp_value = roll_giant_strength
    end
  end

  def xp_reward
    # Assume potions are kept/used and therefore only grant xp equal to 1/10th of their value
    return @gp_value / 10
  end

  def roll_dragon_control
    case rand(100)
    when (0...10)
      return 10_000
    when (10...30)
      return 12_000
    when (30...55)
      return 13_000
    when (55...70)
      return 14_000
    when (70...80)
      return 15_000
    when (80...85)
      return 16_000
    else
      return 20_000
    end
  end

  def roll_giant_control
    case rand(20)
    when (0...2)
      return 5_000
    when (2...6)
      return 4_000
    when (6...10)
      return 3_000
    when (10...15)
      return 1_000
    when (15...19)
      return 2_000
    else
      return 6_000
    end
  end

  def roll_giant_strength
    case rand(20)
    when (0...6)
      return 900
    when (6...10)
      return 1_000
    when (10...14)
      return 1_100
    when (14...17)
      return 1_200
    when (17...19)
      return 1_300
    else
      return 1_400
    end
  end
end
