require "terminal-table"

# Class containing a field for Tic Tac Toe game
class Field
  def initialize(size = 3)
    @size = size
    @field = Array.new(size) { Array.new(size) }
  end

  def accessible?(x_cord, y_cord)
    @field[y_cord][x_cord].nil?
  end

  def to_s
    Terminal::Table.new do |t|
      t << @field[0]
      @field[1..].each do |row|
        t << :separator
        t << row
      end
    end.to_s
  end
end
