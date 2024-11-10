require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new('x') }

  describe '#win?' do
    before do
      allow(game).to receive(:puts)
    end

    context 'when player wins' do
      it 'should end the game' do
        board = Array.new(3, 'X')
        bool = -> { game.instance_variable_get(:@end) }
        expect { game.win?(board) }.to change { bool.call }.from(false).to(true)
      end
    end
  end

  describe '#tie?' do
    context 'when board is filled without winner' do
      before do
        allow(game).to receive(:puts)
      end

      it 'should return true' do
        tie_board = %w[X O O O X O X O X]
        result = game.tie?(tie_board)
        expect(result).to eq(true)
      end
    end
  end

  describe '#player_input' do
    context 'when player wants to exit' do
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('exit')
      end

      it 'will change @end instance variable to true' do
        end_variable = -> { game.instance_variable_get(:@end) }
        expect { game.player_input }.to change { end_variable.call }.to(true)
      end
    end

    context 'when input is valid and board location empty' do
      before do
        player_input = '1'
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return(player_input)
        allow(game).to receive(:current_player).and_return('X')
      end

      it 'will change board location to current player' do
        expect { game.player_input }.to change { game.board[0] }.to('X')
      end
    end

    context 'when board location is taken' do
      before do
        invalid_input = '1'
        valid_input = '2'
        game.board[invalid_input.to_i - 1] = 'X'
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'will print error message' do
        error_message = 'Location is taken. Please choose another'
        expect(game).to receive(:puts).with(error_message).once
        game.player_input
      end
    end

    context 'when input is invalid' do
      before do
        invalid_input = 'b'
        valid_input = '2'
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'returns an error message' do
        error_message = 'Please choose from 1 to 9'
        expect(game).to receive(:puts).with(error_message).once
        game.player_input
      end
    end
  end
end
