require './lib/game'
require './lib/board'

describe Game do
  subject(:game) { described_class.new(board) }
  let(:board) { Board.new }

  describe '#play_game' do
    describe 'print_board' do
      it 'sends a message to Board class' do
        expect(board).to receive(:print_board)
        board.print_board
      end
    end
    
    describe '#verify_input' do
      it 'returns value if between 1 and 7' do
        input = 3
        verified_input = game.verify_input(input)
        expect(verified_input).to eq(3)
      end

      it 'returns nil if not between 1 and 7' do
        input = 8
        verified_input = game.verify_input(input)
        expect(verified_input).to eq(nil)
      end

      it 'checks column is available' do
        input = 0
        available = board.column_available?(input)
        expect(available).to eq(input)
      end
    end

    describe '#make_move' do
      context 'it changes the board based on column and player' do
        it 'changes column 0 to X (Player 1)' do
          column = 0
          player = 1
          board_array = board.instance_variable_get(:@board)
          make_move = board.make_move(column, player)
          expect(board_array[0][0]).to eq('X')
          make_move
        end

        it 'changes column 5 to O (Player 2)' do
          column = 5
          player = 2
          board_array = board.instance_variable_get(:@board)
          make_move = board.make_move(column, player)
          expect(board_array[0][5]).to eq('O')
          make_move
        end
      end
    end

    describe '#full?' do
      context 'it checks whether the board is full or not' do
        it 'is not full' do
          expect(board).not_to be_full
        end
      end
    end

    describe 'get_column' do
      it 'is called on the board class' do
        column = 0
        expect(board).to receive(:get_column)
        board.get_column(column)
      end

      context 'it returns a column from the board' do
        it 'returns a non-winning column from the board' do
          column = 0
          str = board.get_column(column)
          expect(str).to eq('')
        end

        it 'returns a winning column from the board' do
          column = 0
          board.make_move(0, 1)
          board.make_move(0, 1)
          board.make_move(0, 1)
          board.make_move(0, 1)
          str = board.get_column(column)
          expect(str).to eq('XXXX')
        end
      end
    end

    describe 'get_row' do
      it 'is called on the board class' do
        row = 0
        expect(board).to receive(:get_row)
        board.get_row(row)
      end

      context 'it returns a row from the board' do
        it 'returns a non-winning row from the board' do
          row = 0
          str = board.get_row(row)
          expect(str).to eq('')
        end

        it 'returns a winning row from the board' do
          row = 0
          board.make_move(0, 1)
          board.make_move(1, 1)
          board.make_move(2, 1)
          board.make_move(3, 1)
          str = board.get_row(row)
          expect(str).to eq('XXXX')
        end
      end
    end
  end
end