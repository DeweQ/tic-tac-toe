require "terminal-table"

# Class containing a field for Tic Tac Toe game
class Field
  def initialize(size = 3)
    @size = size
    @field = Array.new(size) { Array.new(size) { " " } }
  end

  def accessible?(x_cord, y_cord)
    @field.dig(y_cord, x_cord) == " "
  end

  def add_mark(mark, x_cord, y_cord)
    @field[y_cord][x_cord] = mark if accessible?(x_cord, y_cord)
  end

  def to_s
    table = Terminal::Table.new headings: [0, 1, 2, "x/y"], rows: @field, style: { all_separators: true }
    (0...@size).each { |i| table.rows[i] << i }
    table.align_column(3, :center)
    table.to_s
  end
end
