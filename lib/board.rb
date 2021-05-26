class Board
  attr_accessor :board, :last_move

  def initialize
    @board = make_board
    @last_move = []
  end

  def make_board
    @board = Array.new(6) { Array.new(7, ' ') }
  end

  def print_board
    puts <<~HEREDOC
       1 2 3 4 5 6 7
      |#{@board[5][0]}|#{@board[5][1]}|#{@board[5][2]}|#{@board[5][3]}|#{@board[5][4]}|#{@board[5][5]}|#{@board[5][6]}|
      |#{@board[4][0]}|#{@board[4][1]}|#{@board[4][2]}|#{@board[4][3]}|#{@board[4][4]}|#{@board[4][5]}|#{@board[4][6]}|
      |#{@board[3][0]}|#{@board[3][1]}|#{@board[3][2]}|#{@board[3][3]}|#{@board[3][4]}|#{@board[3][5]}|#{@board[3][6]}|
      |#{@board[2][0]}|#{@board[2][1]}|#{@board[2][2]}|#{@board[2][3]}|#{@board[2][4]}|#{@board[2][5]}|#{@board[2][6]}|
      |#{@board[1][0]}|#{@board[1][1]}|#{@board[1][2]}|#{@board[1][3]}|#{@board[1][4]}|#{@board[1][5]}|#{@board[1][6]}|
      |#{@board[0][0]}|#{@board[0][1]}|#{@board[0][2]}|#{@board[0][3]}|#{@board[0][4]}|#{@board[0][5]}|#{@board[0][6]}|
    HEREDOC
  end

  def column_available?(input)
    @board[5][input] == ' ' ? input : nil
  end

  def make_move(input, player, row = 0)
    if @board[row][input] == ' '
      @last_move = [row, input]
      player == 1 ? @board[row][input] = 'X' : @board[row][input] = 'O'
      return
    else
      make_move(input, player, row + 1)
    end
  end

  def full?
    array = @board.flatten
    return true if !array.include? ' '
    false
  end

  def get_column(column)
    list = []
    @board.each { |row| list << row[column] }
    list.join.strip
  end

  def get_row(row)
    list = []
    list << @board[row]
    list.join.strip
  end

  def get_diagonal1(move)
    start = []
    list = []
    result = []
    if move[0] == 0 || move[1] == 0
      start = move
    else
      if move[0] < move[1]
        shift = move[0]
        start = move.map { |num| num - shift }
      else
        shift = move[1]
        start = move.map { |num| num - shift }
      end
    end
    (6 - start[0]).times do
      list << start
      start = start.map { |num| num + 1 }
    end
    list.each { |pos| result << @board[pos[0]][pos[1]] }
    result.join.strip
  end

  def get_diagonal2(move)
    start = move
    list = []
    result = []

    until start[0] == 0 || start[1] == 6 do
      start[0] -= 1
      start[1] += 1
    end
    
    until start[0] == 6 || start[1] == -1 do
      list << start
      start = [start[0] + 1, start[1] - 1]
    end

    list.each { |pos| result << @board[pos[0]][pos[1]]}
    result.join.strip
  end
end