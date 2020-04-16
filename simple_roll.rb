MINIMUM_ABILITIES = {
  # Assume a minimum of 3 if no other given
  assassin: [12, 12, 6, 11, 6, 3],
  cleric: [6, 3, 6, 6, 9, 6],
  druid: [6, 6, 6, 6, 12, 15],
  fighter: [9, 6, 7, 3, 6, 6],
  illusionist: [6, 16, 3, 15, 6, 6],
  magic_user: [3, 6, 9, 6, 6, 6],
  paladin: [12, 6, 9, 9, 13, 17],
  ranger: [13, 6, 14, 13, 14, 6],
  thief: [6, 9, 6, 6, 3, 6]
}

def mdn(m, n)
  result = 0
  m.times do
    result += rand(n) + 1
  end
  result
end

def roll_ability_scores
  Array.new(6) { mdn(3, 6) }
end

def level_without_dying?(ability_scores)
  rand(20) < (ability_scores.any? { |score| score > 15 } ? 11 : 10)
end

def qualified?(ability_scores, minimums)
  ability_scores.zip(minimums).all? { |pair| pair.first >= pair.last }
end

def qualified_classes(ability_scores, classes=MINIMUM_ABILITIES.keys)
  possible_classes = []
  classes.each do |c|
    possible_classes << c if qualified?(ability_scores, MINIMUM_ABILITIES[c])
  end
  possible_classes
end

def rate_choice(ability_scores, choice)
  ability_scores.zip(MINIMUM_ABILITIES[choice]).map { |pair| pair.first * pair.last}.inject(:+)
end

def pick_class(ability_scores, classes)
  best_classes = []
  best_rating = 0
  classes.each do |pick|
    rating = rate_choice(ability_scores, pick)
    if rating > best_rating
      best_classes = [pick]
      best_rating = rating
    elsif rating == best_rating
      best_classes << pick
    end
  end
  best_classes.sample
end

def roll_1st_level(classes=MINIMUM_ABILITIES.keys)
  ability_scores = roll_ability_scores
  while qualified_classes(ability_scores, classes).empty?
    ability_scores = roll_ability_scores
  end
  ability_scores
end

def makes_it_to_nth_level?(n, ability_scores)
  return true if n < 2
  return false if !level_without_dying?(ability_scores)
  return makes_it_to_nth_level?(n-1, ability_scores)
end

def roll_nth_level(n, minimums)
  ability_scores = roll_1st_level(minimums)
  while !makes_it_to_nth_level?(n, ability_scores)
    ability_scores = roll_1st_level(minimums)
  end
  ability_scores
end

def ordinal(n)
  if n % 100 / 10 != 1
    if n % 10 == 1
      return "#{n}st"
    elsif n % 10 == 2
      return "#{n}nd"
    elsif n % 10 == 3
      return "#{n}rd"
    end
  end
  "#{n}th"
end

if __FILE__ == $PROGRAM_NAME
  ability_scores = roll_1st_level
  possible_classes = qualified_classes(ability_scores)
  chosen_class = pick_class(ability_scores, possible_classes)
  class_string = chosen_class.to_s.split('_').join(' ')

  maximum_level = 1
  while level_without_dying?(ability_scores)
    maximum_level += 1
  end
  actual_level = rand(maximum_level) + 1

  level_string = ordinal(actual_level)
  print "#{level_string} level #{class_string}\n"
  print "#{ability_scores}\n"
end
