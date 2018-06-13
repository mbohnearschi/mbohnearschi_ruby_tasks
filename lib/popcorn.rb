require 'securerandom'

class WordHolder
  attr_accessor :used_letter_ids

  def initialize
    @used_letter_ids = []
  end

  def build_word(letters)
    @used_letter_ids.map { |id| letters[id] }.join
  end

  def copy(used_letter_ids)
    instance = dup
    instance.used_letter_ids = used_letter_ids
    instance
  end
end

class PopcornSolver
  attr_accessor :letters, :connections

  def initialize(letters, connections)
    @letters = letters
    @connections = connections
  end

  def words
    found_words = []
    0.upto(@letters.size - 1) do |letter_idx|
      found_words += find_words(WordHolder.new, letter_idx)
    end
    found_words.uniq
  end

  def find_words(word_holder, current_letter_idx)
    found_words = []

    if word_holder.used_letter_ids.include?(current_letter_idx)
      word = word_holder.build_word(letters)
      found_words += [word] if valid_word?(word)
    else
      new_used_letter_ids = word_holder.used_letter_ids + [current_letter_idx]
      new_word_holder = word_holder.copy(new_used_letter_ids)

      connections[current_letter_idx].each do |connection_idx|
        found_words += find_words(new_word_holder, connection_idx)
      end
    end

    found_words
  end

  def valid_word?(word)
    %w[POP CAT DOG ROCK POPCORN CORN].include?(word)
  end
end
