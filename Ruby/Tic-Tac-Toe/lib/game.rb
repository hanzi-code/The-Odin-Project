require_relative 'board'
require_relative 'player'

class Game
  def initialize(player_1, player_2)
    @board = Board.new
    @current_player_id = 0
    @players = [
      player_1.new(@board, 'X'),
      player_2.new(@board, 'O')
    ]
    return unless @players.any?(&:nil?)

    raise 'Player initialization failed!'
  end

  def current_player
    player = @players[@current_player_id]
    raise "No player found at index #{@current_player_id} in @players array" unless player

    player
  end

  def play
    loop do
      @board.print_board
      puts ''
      place_player_marker(current_player)

      if @board.winner?(current_player.marker)
        puts "#{current_player.marker} wins!"
        return
      elsif @board.full?
        puts "It's a draw!"
        @board.print_board
        return
      end
      switch_players!
    end
  end

  def place_player_marker(player)
    position = player.select_position!
    @board.mark_position(position, player.marker)
  end

  def switch_players!
    @current_player_id = 1 - @current_player_id
  end
end
