require 'json'
require_relative 'dictionary'
require_relative 'display'
require_relative 'game'
require_relative 'game_state'

class Save
  def self.save(game_status, filename)
    data = {
      secret_world: game_status.secret_word,
      correct_letters: game_status.correct_letters,
      incorrect_letters: game_status.incorrect_letters,
      remaining_guesses: game_status.remaining_guesses
    }
    File.write(filename, JSON.dump(data))
  end

  def self.load(filename)
    data = JSON.parse(File.read(filename), symbolize_names: true)

    required_keys = %i[secret_word correct_letters incorrect_letters remaining_guesses]
    return nil unless required_keys.all? { |key| data.key?(key) }

    GameState.new(
      data[:secret_word],
      data[:correct_letters],
      data[:incorrect_letters],
      data[:remaining_guesses]
    )
  rescue StandardError
    nil
  end
end
