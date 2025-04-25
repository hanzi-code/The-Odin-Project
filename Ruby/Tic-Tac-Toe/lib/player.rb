require_relative 'board'

class Player
  attr_reader :marker

  def initialize(board, marker)
    @board = board
    @marker = marker
  end

  def select_position!
    raise NotImplementedError, 'Implement me in a subclass!'
  end
end

class HumanPlayer < Player
  def select_position!
    loop do
      print "Select your #{@marker} position (1-9): "
      position = gets.to_i
      return position if @board.available_positions.include?(position)

      puts 'Invalid Position! Try again.'
    end
  end
end

class ComputerPlayer < Player
  def select_position!
    available = @board.available_positions
    position = available.sample
    puts "Computer chooses #{position}"
    position
  end
end
