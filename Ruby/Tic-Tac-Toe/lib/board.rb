class Board
  WINNING_LINES = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9], # rows
    [1, 4, 7], [2, 5, 8], [3, 6, 9], # columns
    [1, 5, 9], [3, 5, 7] # diagonals
  ]

  def initialize
    @board = Array.new(10)
  end

  def print_board
    col_separator = '|'
    row_separator = '-|-|-'
    positions = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

    row = positions.map do |row|
      row.map { |position| @board[position] || position }.join(col_separator)
    end

    puts row.join("\n#{row_separator} \n")
  end

  def mark_position(position, marker)
    @board[position] = marker
  end

  def position_empty?(position)
    @board[position].nil?
  end

  def full?
    (1..9).none? { |position| @board[position].nil? }
  end

  def winner?(marker)
    WINNING_LINES.any? do |line|
      line.all? { |position| @board[position] == marker }
    end
  end

  def available_positions
    (1..9).select { |position| @board[position].nil? }
  end
end
