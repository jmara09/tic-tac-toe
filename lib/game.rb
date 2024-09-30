class Game
  WIN_COMBINATION = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  attr_reader :board, :current_player

  def initialize(chr)
    raise "Please choose between 'X' and 'O'" unless chr.upcase == 'X' || chr.upcase == 'O'
    @current_player = chr.upcase
    @board = Array.new(9, '')
    @end = false
  end

  def start
    puts "Welcome! Let's play Tic-Tac-Toe. You can choose a location\n"\
         "from the board starting from upper left by choosing between 1-9"
    loop do
      current_board
      player_input
      break if @end == true
    end
  end

  private

  def current_board
    puts <<~BOARD
      \nTIC TAC TOE\n
         #{board[0]} | #{board[1]} | #{board[2]}
      -------------
         #{board[3]} | #{board[4]} | #{board[5]}
      -------------
         #{board[6]} | #{board[7]} | #{board[8]}\n
    BOARD
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
        puts "Location is taken. Please choose another"
      elsif ('a'..'z').include?(location.downcase)
        puts "Please choose from 1 to 9"
      end  
    end
    
    case
    when @current_player == 'X'
      @current_player = 'O'
    else
      @current_player = 'X'
    end 
  end

  def win_or_tie
    w
  end
end
