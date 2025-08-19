require_relative "field"

# Class to play a tic-tac-toe game
class TicTacToe
  NO_WINNER = "None".freeze
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
    puts field.to_table
  end

  def check_winner
    return winner_in_rows if winner_in_rows != NO_WINNER
    return winner_in_columns if winner_in_columns != NO_WINNER
    return winner_in_diagonal if winner_in_diagonal != NO_WINNER

    winner_in_anti_diagonal if winner_in_anti_diagonal
  end

  def finished?
    check_winner != "None" || field.all? do |row|
      row.all? { |cell| cell != " " }
    end
  end

  private

  attr_accessor :field
  attr_writer :current_player

  def winner_in_rows
    field.any? { |row| return row[0] if row.uniq.size == 1 && row[0] != " " }
    NO_WINNER
  end

  def winner_in_columns
    field.to_ary.transpose.any? { |column| return column[0] if column.uniq.size == 1 && column[0] != " " }
    NO_WINNER
  end

  def winner_in_diagonal
    diagonal = (0...field.size).map { |i| field[i][i] }
    return diagonal[0] if diagonal.uniq.size == 1 && diagonal[0] != " "

    NO_WINNER
  end

  def winner_in_anti_diagonal
    anti_diagonal = (0...field.size).map { |i| field[i][field.size - 1 - i] }
    return anti_diagonal[0] if anti_diagonal.uniq.size == 1 && anti_diagonal[0] != " "

    NO_WINNER
  end

  def toggle_current_player
    self.current_player = current_player == "X" ? "O" : "X"
  end
end
