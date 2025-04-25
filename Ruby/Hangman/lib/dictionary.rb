require_relative 'display'
require_relative 'game'
require_relative 'game_state'
require_relative 'save'

class Dictionary
  def initialize(file_path)
    file = File.expand_path(file_path, __dir__)
    @words = File.readlines(file)
                 .map(&:chomp)
                 .select { |word| word.length.between?(5, 12) }
  end

  def random_word
    @words.sample.downcase
  end

  def words_with_length(length)
    @words.select { |word| word.length == length }
  end
end
