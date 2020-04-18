module OsricSupport
  def roll(str)
    parsing = parse_dice(str)

    result = (1..parsing[0]).map { rand(parsing[2]) + 1 }.inject(:+)
    
    if parsing[3] == '+'
      result += parsing[4]
    elsif parsing[3] == '-'
      result -= parsing[4]
    end
    result
  end

  def parse_dice(str)
    parsing = []
    number_builder = ""
    
    str.each_char do |char|
      if char.match?(/[0-9]/)
        number_builder << char
      elsif char.match?(/[d+-]/)
        parsing << number_builder.to_i
        number_builder = ""
        parsing << char
      else
        raise ArgumentError
      end
    end

    parsing << number_builder.to_i if !number_builder.empty?
    parsing = parsing.take(1) + ['d', 8] + parsing.drop(1) if parsing[1] != 'd'
    parsing
  end
end
