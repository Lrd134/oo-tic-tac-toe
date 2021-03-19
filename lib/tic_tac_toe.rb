require 'pry'
class TicTacToe
    
    WIN_COMBINATIONS = [
        [0,1,2], # Top row
        [3,4,5], # Middle row
        [6,7,8], # Bottom row
        [0,3,6], # Bottom-to-top, left to right
        [2,5,8], # Top-to-bottom, right to left
        [8,4,0], # Bottom-to-top, right to left
        [1,4,7], # Top-to-bottom, center
        [2,4,6]  # Top-to-bottom, left side
        # et cetera, creating a nested array for each win combination
      ]
    def initialize(board = nil)
        @board = board || Array.new(9, " ")
       
    end

    def display_board
        print " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        print " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        print " #{@board[6]} | #{@board[7]} | #{@board[8]} "
        print "-----------"
    end
    def input_to_index(stringdex)
        stringdex.to_i - 1
    end
    def move(index, piece)
         @board[index] = piece
    end
    def position_taken?(index)
        @board[index] == " " ? false : true
    end
    def valid_move?(index)
        index < 9 && index > -1 ? !position_taken?(index) : false
        
    end
    def turn_count
        @board.count { | piece | piece == "X" || piece == "O"}
    end
    def current_player
        turn_count.even? ? "X" : "O"
    end
    def turn
        user_input = gets.strip
        index_num = input_to_index(user_input)
        if valid_move?(index_num)
            move(index_num, current_player)
            display_board
        else
            turn
        end
    end
    def won?
        WIN_COMBINATIONS.detect do | win_combo |
            if @board[win_combo[0]] == @board[win_combo[1]] && @board[win_combo[1]]  == @board[win_combo[2]] && @board[win_combo[0]]  == @board[win_combo[2]]
                return win_combo
            end
        end
    end
    def full?
        if won?
            false
        elsif turn_count > 8
            true
        end
    end
    def draw?
        full?
    end
    def over?
        if draw? || won?
            true
        else
            false
        end
    end
    def winner
        win_combos = won?
        if !win_combos.nil? && @board[win_combos[0]] != " "
            @board[win_combos[0]]
        else
            nil
        end
    end
end