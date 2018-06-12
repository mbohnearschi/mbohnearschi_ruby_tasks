require 'securerandom'

class WordHolder
  attr_accessor :id, :used_letter_ids, :word

  def initialize
    @id = SecureRandom.uuid.to_s
    @used_letter_ids = []
    @word = ''
  end

  def copy(used_letter_ids, word)
    instance = dup
    instance.used_letter_ids = used_letter_ids
    instance.word = word
    instance
  end
end

class Letter
  attr_accessor :id, :value, :neighbours

  def initialize(value)
    @id = SecureRandom.uuid.to_s
    @value = value
    @neighbours = []
  end

end

class PopcornSolver
  attr_accessor :letter_elements

  def initialize
    p1 = Letter.new('P')
    o1 = Letter.new('O')
    r1 = Letter.new('R')
    n1 = Letter.new('N')
    p2 = Letter.new('P')
    o2 = Letter.new('O')
    c1 = Letter.new('C')
    c2 = Letter.new('C')
    p1.neighbours = [o1, r1, n1]
    o1.neighbours = [p1, r1, p2, o2]
    r1.neighbours = [p1, o1, n1, o2]
    n1.neighbours = [p1, r1, o2, c1]
    p2.neighbours = [o1, o2, c2]
    o2.neighbours = [o1, p2, c2, c1, n1, r1]
    c1.neighbours = [n1, o2, c2]
    c2.neighbours = [p2, o2, c1]
    @letter_elements = [p1, o1, r1, n1, p2, o2, c1, c2]
  end

  def words
    found_words = []
    @letter_elements.each do |letter|
      found_words += find_words(WordHolder.new, letter)
    end
    found_words.uniq
  end

  def find_words(word_holder, current_letter)
    found_words = []

    if word_holder.used_letter_ids.include?(current_letter.id)
      found_words += [word_holder.word] if word? word_holder.word
    else
      new_used_letter_ids = word_holder.used_letter_ids + [current_letter.id]
      new_word = word_holder.word + current_letter.value
      new_word_holder = word_holder.copy(new_used_letter_ids, new_word)

      current_letter.neighbours.each do |letter|
        found_words += find_words(new_word_holder, letter)
      end
    end

    found_words
  end

  def word?(word)
    %w[POP CAT DOG ROCK POPCORN CORN].include?(word)
  end
end

popcorn_solver = PopcornSolver.new
popcorn_solver.words.each do |word|
  puts "#{word} is a word"
end