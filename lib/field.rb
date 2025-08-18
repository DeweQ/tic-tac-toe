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

  def finished?
    @field.all? do |row|
      row.all? { |cell| cell != " " }
    end
  end

  def check_winner
    return unless finished?

    winner = "Draw"
    @field.any? { |row| winner = row[0] if row.uniq.size == 1 }
    @field.transpose.any? { |column| winner = column[0] if column.uniq.size == 1 }
    diagonal = (0...@size).map { |i| @field[i][i] }
    winner = diagonal[0] if diagonal.uniq.size == 1
    anti_diagonal = (0...@size).map { |i| @field[i][@size - 1 - i] }
    winner = anti_diagonal[0] if anti_diagonal.uniq.size == 1
    winner
  end

  def to_s
    table = Terminal::Table.new headings: [0, 1, 2, "x/y"], rows: @field, style: { all_separators: true }
    (0...@size).each { |i| table.rows[i] << i }
    table.align_column(3, :center)
    table.to_s
  end
end
