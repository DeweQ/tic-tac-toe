require_relative "field"

# Class to play a tic-tac-toe game
class TicTacToe
  def initialize(field_size = 3)
    @field = Field.new(field_size)
    @current_player = "X"
  end

  attr_reader :current_player

  def mark_field(x_cord, y_cord)
    return "Invalid coordinates" unless field.accessible?(x_cord, y_cord)

    field.add_mark(current_player, x_cord, y_cord)
    toggle_current_player
  end

  def print_field
    puts field
  end

  def finished?
    field.finished?
  end

  def check_winner
    field.check_winner
  end

  private

  attr_accessor :field
  attr_writer :current_player

  def toggle_current_player
    self.current_player = current_player == "X" ? "O" : "X"
  end
end
