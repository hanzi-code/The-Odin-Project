require_relative 'dictionary'
require_relative 'display'
require_relative 'game_state'
require_relative 'save'

class Game
  def initialize
    @dictionary = Dictionary.new('words.txt')
    @display = Display.new(nil)
  end

  def start
    @display.show_menu
    option = gets.chomp

    @game_state = if option == '2'
                    @display.show_load_prompt
                    filename = gets.chomp
                    Save.load(filename) || new_game
                  else
                    new_game
                  end

    @display = Display.new(@game_state)
    play_round until @game_state.game_over?

    @display.show_stickman(@game_state.incorrect_letters.size)
    @display.show_status
    @display.show_game_over
  end

  private

  def new_game
    GameState.new(@dictionary.random_word)
  end

  def play_round
    @display.show_stickman(@game_state.incorrect_letters.size, animate: true)
    @display.show_status
    @display.show_guess_prompt
    input = gets.chomp.downcase

    if input == 'save'
      @display.show_save_prompt
      filename = gets.chomp
      Save.save(@game_state, filename)
      @display.show_save_success(filename)
      return
    end

    if input.length != 1 || !input.match?(/[a-z]/)
      @display.show_invalid_input
      return
    end

    if @game_state.correct_letters.include?(input) || @game_state.incorrect_letters.include?(input)
      @display.show_duplicate_guess
      return
    end

    @game_state.make_guess(input)
  end
end
