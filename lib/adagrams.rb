# Our first job is to build a hand of 10 letters for the user. To do so, add a method called draw_letters in adagrams.rb. This method should have the following properties:

#   No parameters
#   Returns an array of ten strings
#   Each string should contain exactly one letter
#   These represent the hand of letters that the player has drawn
#   The letters should be randomly drawn from a pool of letters
#   This letter pool should reflect the distribution of letters as described in the table below
#   There are only 2 available C letters, so draw_letters cannot ever return more than 2 Cs
#   Since there are 12 Es but only 1 Z, it should be 12 times as likely for the user to draw an E as a Z
#   Invoking this method should not change the pool of letters (USING METHOD CALLED ARRAY.SAMPLE HERE)
#   Imagine that the user returns their hand to the pool before drawing new letters

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

#Global Variables to use later outside the scope
HAND_SIZE = 10 #Setting hand size to global variable will let us manually change it to a different size in the future

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

def play_game
  puts "Welcome to Adagrams."
  puts "Try to make words with your letters."
  puts "Your letters are:"

  def draw_letters() #Global variable LETTER_POOL would need to be passed as a paramter but reqs said no parameters so made it global
    letters_in_hand = [] #array of letters
    letters_in_hand = LETTER_POOL.sample(HAND_SIZE) #using .sample to randomly select letters WITHOUT changing letter_pool
    return letters_in_hand #returning the array of letters /// can also simply return LETTER_POOL.sample(10)
  end

  letters_in_hand = draw_letters()

  puts letters_in_hand.join

  # Wave 2
  # Next, we need a way to check if an input word (a word a player submits) only uses characters that are contained within a collection (or hand) of drawn letters. Essentially, we need a way to check if the word is, indeed, an anagram of some or all of the given letters in the hand.

  # To do so, add a method called uses_available_letters? in adagrams.rb. This method should have the following properties:

  # Has two parameters:
  # input, the first parameter, describes some input word, and is a string
  # letters_in_hand, the second parameter, describes an array of drawn letters in a hand. You can expect this to be an array of ten strings, with each string representing a letter
  # Returns either true or false
  # Returns true if every letter in the input word is available (in the right quantities) in the letters_in_hand
  # Returns false if not; if there is a letter in input that is not present in the letters_in_hand or has too much of compared to the letters_in_hand

  puts "What's your word?"
  user_input = gets.chomp.upcase
  @your_words = []

  def uses_available_letters?(input, letters_in_hand)
    current_hand = letters_in_hand.dup
    word_characters = input.split("")
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

  isUserInputValid = uses_available_letters?(user_input, letters_in_hand)

  # Wave 3
  # We want a method that returns the score of a given word as defined by the Adagrams game.

  # Name this method score_word in adagrams.rb. This method should have the following properties:

  # Has one parameter: word, which is a string of characters
  # Returns an integer representing the number of points
  # Each letter within word has a point value. The number of points of each letter is summed up to represent the total score of word
  # Each letter's point value is described in the table below
  # If the length of the word is 7, 8, 9, or 10, then the word gets an additional 8 points

  def score_word(word)
    word
    score = 0
    if (word.length >= 7) && (word.length <= 10)
      score = 8
    end
    word.split("").each do |letter|
      score = LETTER_INFO[letter.upcase][:score] + score
    end
    return score
  end

  words = []
  #Checking ONE time, prints only if true.
  if isUserInputValid
    puts "Your score is #{score_word(user_input)}."
    words << user_input
  else
    puts "Your input is not valid, therefore not scored."
  end

  #Optional
  require "csv"
  # ENGLISH_DICTIONARY = CSV.parse(File.read("./assets/dictionary-english.csv"), headers: true)

  # def is_in_english_dict?(input)
  #   #https://www.rubyguides.com/2018/10/parse-csv-ruby/
  #   #method looking at the column which is list of words in the dictionary
  #   return ENGLISH_DICTIONARY.by_col[0].include?(input.downcase)
  # end

  # #Checking ONE time, prints only if true.
  # if isUserInputValid
  #   puts "Your word is in the Engligh Dictionary: #{is_in_english_dict?(user_input)}."
  # else
  #   puts "Your input is not valid, therefore not checked in English dictionary."
  # end
end

play_game
