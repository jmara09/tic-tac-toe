class Game
  WIN_COMBINATION = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  attr_reader :board, :current_player

  def initialize(chr)
    raise "Please choose between 'X' and 'O'" unless chr.downcase == 'x' || chr.downcase == 'o'

    @current_player = chr.downcase
    @board = Array.new(9, '')
    @end = false
  end

  def start
    puts "Welcome! Let's play Tic-Tac-Toe. You can choose a location\n" \
         'from the board starting from upper left by choosing between 1-9'
    loop do
      player_input
      win_or_tie(@board)
      current_board(@board)
      break if @end == true
    end
  end

  private

  def current_board(board)
    arr = 0
    (1..5).each do |num|
      if num.odd?
        puts " #{board[arr]} | #{board[arr + 1]} | #{board[arr + 2]} "
        arr += 3
      else
        puts '-----------'
      end
    end
  end

  def player_input
    puts "Player '#{current_player}' please pick a location from the board. Type 'exit' to stop"
    loop do
      location = gets.chomp
      if location.downcase == 'exit'
        puts "Thank you for your time! Let's play again next time."
        @end = true
        break
      end

      if location.to_i.between?(1, 9) && @board[location.to_i - 1].empty?
        @board[location.to_i - 1] = current_player
        break
      elsif !@board[location.to_i - 1].empty?
        puts 'Location is taken. Please choose another'
      elsif ('a'..'z').include?(location.downcase)
        puts 'Please choose from 1 to 9'
      end
    end

    @current_player = @current_player == 'x' ? 'o' : 'x'
  end

  def win_or_tie(board)
    WIN_COMBINATION.each do |combination|
      case board.values_at(*combination)
      when %w[X X X]
        puts "Congratulations! Player 'X' won."
        @end = true
      when %w[O O O]
        puts "Congratulations! Player 'O' won."
        @end = true
      end
    end
  end
end
