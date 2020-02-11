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

LETTER_INFO ={ 
  "A" => {
      :qty => 9,
      :score => 1
  },
  "B" => {
      :qty => 2,
      :score => 3
  },
  "C" => {
      :qty => 2,
      :score => 3
  },
  "D" => {
      :qty => 4,
      :score => 2
  },
  "E" => {
      :qty => 12,
      :score => 1
  },
  "F" => {
      :qty => 2,
      :score => 4
  },
  "G" => {
      :qty => 3,
      :score => 2
  },
  "H" => {
      :qty => 2,
      :score => 4
  },
  "I" => {
      :qty => 9,
      :score => 1
  },
  "J" => {
      :qty => 1,
      :score => 8
  },
  "K" => {
      :qty => 1,
      :score => 5
  },
  "L" => {
      :qty => 4,
      :score => 1
  },
  "M" => {
      :qty => 2,
      :score => 3
  },
  "N" => {
      :qty => 6,
      :score => 1
  },
  "O" => {
      :qty => 8,
      :score => 1
  },
  "P" => {
      :qty => 2,
      :score => 3
  },
  "Q" => {
      :qty => 1,
      :score => 10
  },
  "R" => {
      :qty => 6,
      :score => 1
  },
  "S" => {
      :qty => 4,
      :score => 1
  },
  "T" => {
      :qty => 6,
      :score => 1
  },
  "U" => {
      :qty => 4,
      :score => 1
  },
  "V" => {
      :qty => 2,
      :score => 4
  },
  "W" => {
      :qty => 2,
      :score => 4
  },
  "X" => {
      :qty => 1,
      :score => 8
  },
  "Y" => {
      :qty => 2,
      :score => 4
  },
  "Z" => {
      :qty => 1,
      :score => 10
  }
}

#Global Variables to use later outside the scope
HAND_SIZE = 10 #Setting hand size to global variable will let us manually change it to a different size in the future

#Creating letter pool array by looping through letter info hash.
LETTER_POOL = [] #Made this a global variable LETTER_POOL in order to use outside of this block of code and our functions can use it
LETTER_INFO.each do |key, value|
  number_of_letters = value[:qty]
  i = 0
  while i < number_of_letters  do
    LETTER_POOL.push(key)  
    i +=1
  end
end

# puts $letter_pool

def draw_letters() #Global variable LETTER_POOL would need to be passed as a paramter but reqs said no parameters so made it global
  letters = [] #array of letters
  letters = LETTER_POOL.sample(HAND_SIZE) #using .sample to randomly select letters WITHOUT changing letter_pool
  return letters #returning the array of letters /// can also simply return LETTER_POOL.sample(10)
end

puts draw_letters()

