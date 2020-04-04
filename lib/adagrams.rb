# Globals
HAND_SIZE = 10 #Setting hand size to global variable will let us manually change it to a different size in the future
LETTER_INFO = {
  "A" => {
    :qty => 9,
    :score => 1,
  },
  "B" => {
    :qty => 2,
    :score => 3,
  },
  "C" => {
    :qty => 2,
    :score => 3,
  },
  "D" => {
    :qty => 4,
    :score => 2,
  },
  "E" => {
    :qty => 12,
    :score => 1,
  },
  "F" => {
    :qty => 2,
    :score => 4,
  },
  "G" => {
    :qty => 3,
    :score => 2,
  },
  "H" => {
    :qty => 2,
    :score => 4,
  },
  "I" => {
    :qty => 9,
    :score => 1,
  },
  "J" => {
    :qty => 1,
    :score => 8,
  },
  "K" => {
    :qty => 1,
    :score => 5,
  },
  "L" => {
    :qty => 4,
    :score => 1,
  },
  "M" => {
    :qty => 2,
    :score => 3,
  },
  "N" => {
    :qty => 6,
    :score => 1,
  },
  "O" => {
    :qty => 8,
    :score => 1,
  },
  "P" => {
    :qty => 2,
    :score => 3,
  },
  "Q" => {
    :qty => 1,
    :score => 10,
  },
  "R" => {
    :qty => 6,
    :score => 1,
  },
  "S" => {
    :qty => 4,
    :score => 1,
  },
  "T" => {
    :qty => 6,
    :score => 1,
  },
  "U" => {
    :qty => 4,
    :score => 1,
  },
  "V" => {
    :qty => 2,
    :score => 4,
  },
  "W" => {
    :qty => 2,
    :score => 4,
  },
  "X" => {
    :qty => 1,
    :score => 8,
  },
  "Y" => {
    :qty => 2,
    :score => 4,
  },
  "Z" => {
    :qty => 1,
    :score => 10,
  },
}

#Creating letter pool array by looping through letter info hash.
LETTER_POOL = [] #Made this a global variable LETTER_POOL in order to use outside of this block of code and our functions can use it
LETTER_INFO.each do |key, value|
  number_of_letters = value[:qty]
  i = 0
  while i < number_of_letters
    LETTER_POOL.push(key)
    i += 1
  end
end

# Methods

# Wave 1
# Our first job is to build a hand of 10 letters for the user. To do so, add a method called draw_letters in adagrams.rb. This method should have the following properties:
# No parameters
# Returns an array of ten strings
# Each string should contain exactly one letter
# These represent the hand of letters that the player has drawn
# The letters should be randomly drawn from a pool of letters
# This letter pool should reflect the distribution of letters as described in the table below
# There are only 2 available C letters, so draw_letters cannot ever return more than 2 Cs
# Since there are 12 Es but only 1 Z, it should be 12 times as likely for the user to draw an E as a Z
# Invoking this method should not change the pool of letters (USING METHOD CALLED ARRAY.SAMPLE HERE)
# Imagine that the user returns their hand to the pool before drawing new letters

def draw_letters() #Global variable LETTER_POOL would need to be passed as a paramter but reqs said no parameters so made it global
  letters_in_hand = [] #array of letters
  letters_in_hand = LETTER_POOL.sample(HAND_SIZE) #using .sample to randomly select letters WITHOUT changing letter_pool
  return letters_in_hand #returning the array of letters /// can also simply return LETTER_POOL.sample(10)
end

# Wave 2
# Next, we need a way to check if an input word (a word a player submits) only uses characters that are contained within a collection (or hand) of drawn letters. Essentially, we need a way to check if the word is, indeed, an anagram of some or all of the given letters in the hand.
# To do so, add a method called uses_available_letters? in adagrams.rb. This method should have the following properties:
# Has two parameters:
# input, the first parameter, describes some input word, and is a string
# letters_in_hand, the second parameter, describes an array of drawn letters in a hand. You can expect this to be an array of ten strings, with each string representing a letter
# Returns either true or false
# Returns true if every letter in the input word is available (in the right quantities) in the letters_in_hand
# Returns false if not; if there is a letter in input that is not present in the letters_in_hand or has too much of compared to the letters_in_hand

def uses_available_letters?(input, letters_in_hand)
  current_hand = letters_in_hand.dup
  word_characters = input.upcase.split("")
  word_characters.each do |letter|
    if !current_hand.include?(letter)
      puts "You're cheating!"
      return false
    else
      current_hand.delete_at(current_hand.index(letter))
    end
  end
  return true
end

# Wave 3
# We want a method that returns the score of a given word as defined by the Adagrams game.
# Name this method score_word in adagrams.rb. This method should have the following properties:
# Has one parameter: word, which is a string of characters
# Returns an integer representing the number of points
# Each letter within word has a point value. The number of points of each letter is summed up to represent the total score of word
# Each letter's point value is described in the table below
# If the length of the word is 7, 8, 9, or 10, then the word gets an additional 8 points

def score_word(word)
  score = 0
  if (word.length >= 7) && (word.length <= 10)
    score = 8
  end
  word.split("").each do |letter|
    score = LETTER_INFO[letter.upcase][:score] + score
  end
  return score
end

# Wave 4
# After several hands have been drawn, words have been submitted, checked, scored, and played, we want a way to find the highest scoring word. This method looks at the array of words and calculates which of these words has the highest score, applies any tie-breaking logic, and returns the winning word in a special data structure.
# Add a method called highest_score_from in adagrams.rb. This method should have the following properties:
# Has one parameter: words, which is an array of strings
# Returns a single hash that represents the data of a winning word and its score. The hash should have the following keys:
# :word, whose value is a string of a word
# :score, whose value is the score of that word

# In the case of tie in scores, use these tie-breaking rules:
# prefer the word with the fewest letters...
# ...unless one word has 10 letters. If the top score is tied between multiple words and one is 10 letters long, choose the one with 10 letters over the one with fewer tiles
# If the there are multiple words that are the same score and the same length, pick the first one in the supplied list

def highest_score_from(words)
  word_hash = {
 #:word => "hello",
       #:score => score_word("hello")
    }
  #words = ["tree", "the", "they", "them"]
  highest_score = 0
  highest_word = ""
  words.each do |word|
    word_score = score_word(word)
    if word_score > highest_score #check for highest score
      highest_score = word_score
      highest_word = word
    elsif word_score == highest_score #tie break block until 218
      if highest_word.length != 10
        if (word.length == 10) #If the there are multiple words that are the same score and the same length, pick the first one in the supplied list. Setting the first word as the winner.
          highest_word = word
        elsif (word.length < highest_word.length)
          highest_word = word
        end
      end
    end
  end
  word_hash = { :word => highest_word, :score => highest_score }
  return word_hash
end

# Optional: Wave 5
# We want to be able to verify that a word that a player submits is a valid word against the English dictionary.
# We have the English dictionary available as a CSV file. We want to write a method that checks an input word against the words listed in the CSV file. If the word is found in the CSV file, then the word is valid and can be played.
# Add a method called is_in_english_dict? in adagrams.rb. This method should have the following properties:
# Has one parameter: input, which is a string
# Returns a boolean
# true, if input is in the provided English dictionary
# false, if input is not in the provided English dictionary
# Uses the English dictionary found in assets/dictionary-english.csv

require "csv"

# https://stackoverflow.com/a/29148595
ENGLISH_DICTIONARY = CSV.parse(File.read(__dir__ + "/../assets/dictionary-english.csv"), headers: true) #relative to ADAGRAMS not the workspace

def is_in_english_dict?(input)
  # https://www.rubyguides.com/2018/10/parse-csv-ruby/
  #method looking at the column which is list of words in the dictionary
  return ENGLISH_DICTIONARY.by_col[0].include?(input.downcase)
end

def play_again_or_quit
  puts "Would you like to play again? Type Y to play again."
  should_continue = gets.chomp.upcase

  if should_continue == "Y"
    play_game
  end
end

def play_game
  puts "Welcome to Adagrams."
  puts "Try to make words with your letters."
  puts "Your letters are:"

  letters_in_hand = draw_letters()
  puts letters_in_hand.join

  puts "What's your word?"
  user_input = gets.chomp.upcase
  @your_words = []

  isUserInputValid = uses_available_letters?(user_input, letters_in_hand)
  words = []
  #Checking ONE time, prints only if true.
  if isUserInputValid
    puts "Your score is #{score_word(user_input)}."
    words << user_input
  else
    puts "Your input is not valid, therefore not scored."
  end

  #Checking ONE time, prints only if true.
  if isUserInputValid
    puts "Your word is in the Engligh Dictionary: #{is_in_english_dict?(user_input)}."
  else
    puts "Your input is not valid, therefore not checked in English dictionary."
  end

  play_again_or_quit
end

play_game
