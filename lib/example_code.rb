# A method looks at the array of words and calculates which of these words has the highest score.
def highest_score_from(words)
  maximum_score = words.map { |word| score_word(word) }.max
  highest = words.select { |word| score_word(word) == maximum_score }
  if highest.length == 1
    winning_word = highest.first
  else
    highest_lengths = highest.map { |i| i.length }
    if highest_lengths.any? { |x| x == 10 }
      index_of_length_10 = highest_lengths.find_index(10)
      winning_word = highest[index_of_length_10]
    else
      winning_word = highest[highest_lengths.find_index(highest_lengths.min)]
    end
  end
  results = Hash.new
  results[:score] = maximum_score
  results[:word] = winning_word
  return results
end
