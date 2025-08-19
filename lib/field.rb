require "terminal-table"

# Class containing a field for Tic Tac Toe game
class Field
  include Enumerable

  # Protected row class to grant access to it only for Field class
  class ProtectedRow
    include Enumerable

    def initialize(size = 3)
      @size = size
      @row = Array.new(size) { " " }
    end

    def each(&block)
      row.each(&block)
    end

    def dig(*keys)
      row.dig(*keys)
    end

    def [](index)
      row[index]
    end

    def []=(index, value)
      row[index] = value
    end

    def to_s
      row.to_s
    end

    protected

    attr_accessor :row
  end

  def initialize(size = 3)
    @size = size
    @field = Array.new(size) { ProtectedRow.new(@size) }
  end

  def each(&block)
    field.each(&block)
  end

  def [](index)
    field[index]
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

  protected

  attr_accessor :field
end
