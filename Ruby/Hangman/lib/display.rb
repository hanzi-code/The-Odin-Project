require_relative 'dictionary'
require_relative 'game'
require_relative 'game_state'
require_relative 'save'

class Display
  def initialize(game_state)
    @game_state = game_state
  end

  STICKMAN = [
    '  +---+',
    '  |   |',
    '      |',
    '      |',
    '      |',
    '      |',
    '========='
  ]

  STICKMAN_PARTS = [
    [2, '  O   |'],
    [3, '  |   |'],
    [3, ' /|   |'],
    [3, ' /|\\  |'],
    [4, ' /    |'],
    [4, ' / \\  |']
  ]

  def show_stickman(incorrect_guesses, animate: false)
    stickman = STICKMAN.dup

    if animate
      incorrect_guesses.times do |i|
        next if i >= STICKMAN_PARTS.size

        line, part = STICKMAN_PARTS[i]
        stickman[line] = part
        system('clear') || system('cls')
        puts stickman.join("\n")
        sleep(0.3)
      end
    else
      incorrect_guesses.times do |i|
        next if i >= STICKMAN_PARTS.size

        line, part = STICKMAN_PARTS[i]
        stickman[line] = part
      end
      puts stickman.join("\n")
    end
  end

  def show_status
    puts "\nSecret Word: #{@game_state.display_word}"
    puts "Incorrect Guesses: #{@game_state.incorrect_letters.join(', ')}" unless @game_state.incorrect_letters.empty?
    puts "Remaining Guesses: #{@game_state.remaining_guesses}"
  end

  def show_game_over
    if @game_state.won?
      puts 'Congratulations! Yow Won!'
    else
      puts "Game Over! You Lost. The word was: #{@game_state.secret_word}"
    end
  end

  def show_menu
    puts "\nWelcome to Hangman!"
    puts '1. New Game'
    puts '2. Load Game'
    print 'Choose an option: '
  end

  def show_save_prompt
    print 'Enter a filename to save as: '
  end

  def show_load_prompt
    print 'Enter a save filename: '
  end

  def show_guess_prompt
    print "Enter a letter to guess (or 'save' to save the game): "
  end

  def show_invalid_input
    puts 'Please enter a single letter from a-z.'
  end

  def show_duplicate_guess
    puts 'You already guessed that letter.'
  end

  def show_save_success(filename)
    puts "Game saved succssesfully as #{filename}"
  end

  def show_load_error
    puts 'Error! Loading Saved Game.'
  end
end
