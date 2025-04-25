require_relative 'dictionary'
require_relative 'display'
require_relative 'game'
require_relative 'save'

class GameState
  MAX_GUESSES = 8

  attr_reader :secret_word, :correct_letters, :incorrect_letters, :remaining_guesses

  def initialize(secret_word, correct_letters = [], incorrect_letters = [], remaining_guesses = MAX_GUESSES)
    @secret_word = secret_word
    @correct_letters = correct_letters
    @incorrect_letters = incorrect_letters
    @remaining_guesses = remaining_guesses
  end

  def make_guess(letter)
    letter = letter.downcase
    if @secret_word.include?(letter)
      @correct_letters << letter unless @correct_letters.include?(letter)
    else
      @incorrect_letters << letter unless @incorrect_letters.include?(letter)
      @remaining_guesses -= 1
    end
  end

  def game_over?
    won? || lost?
  end

  def won?
    (@secret_word.chars.uniq - @correct_letters).empty?
  end

  def lost?
    @remaining_guesses <= 0
  end

  def display_word
    @secret_word.chars.map do |char|
      @correct_letters.include?(char) ? char : '_'
    end.join(' ')
  end
end
