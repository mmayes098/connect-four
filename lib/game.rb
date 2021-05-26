require_relative './board'
require 'byebug'

class Game
  def initialize(board)
    @board = board
    @input = nil
  end

  def play_game(player = 1)
    @board.print_board
    @input = get_input(player)
  end

  def get_input(player)
    # debugger
    puts "Player #{player}, please select a column to drop your counter"
    input = gets.chomp.to_i
    verified_input = verify_input(input)
    verified_input.nil? ? get_input(player) : @input = verified_input
    @board.make_move(@input, player)
    unless game_won?
      unless @board.full?
        player == 1 ? player = 2 : player = 1
        play_game(player)
      else
        full_board(player)
      end
    end

    end_game(player)
  end

  def verify_input(input)
    if input.between?(1, 7)
      @board.column_available?(input - 1).nil? ? nil : input - 1
    else
      nil
    end
  end

  def game_won?
    last_move = @board.last_move
    column = @board.get_column(last_move[1])
    row = @board.get_row(last_move[0])
    diagonal1 = @board.get_diagonal1(last_move)
    diagonal2 = @board.get_diagonal2(last_move)
  
    if row.include?('XXXX') || row.include?('OOOO')
      true
    elsif column.include?('XXXX') || column.include?('OOOO')
      true
    elsif diagonal1.include?('XXXX') || diagonal1.include?('OOOO')
      true
    elsif diagonal2.include?('XXXX') || diagonal2.include?('OOOO')
      true
    else
      false
    end
  end

  def end_game(player)
    puts "Congratulations Player #{player}, you have won the game!"
    @board.print_board
    exit
  end

  def full_board(player)
    puts "The board is full and no one has won the game!"
    @board.print_board
    exit
  end
end