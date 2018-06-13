require 'securerandom'

class WordHolder
  attr_accessor :id, :used_letter_ids

  def initialize
    @id = SecureRandom.uuid.to_s
    @used_letter_ids = []
  end

  def build_word(letter_elements)
    word = ''
    @used_letter_ids.each do |id|
      wor
    end
  end

  def copy(used_letter_ids)
    instance = dup
    instance.used_letter_ids = used_letter_ids
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

  def initialize(letter_elements)
    @letter_elements = letter_elements
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
      new_word_holder = word_holder.copy(new_used_letter_ids)

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