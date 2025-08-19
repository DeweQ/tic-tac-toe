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

    def to_ary
      @row
    end

    def to_s
      row.to_s
    end

    protected

    attr_accessor :row
  end

  attr_reader :size

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
    ![x_cord, y_cord].include?(nil) && @field.dig(y_cord, x_cord) == " "
  end

  def add_mark(mark, x_cord, y_cord)
    @field[y_cord][x_cord] = mark if accessible?(x_cord, y_cord)
  end

  def transpose
    @field.transpose
  end

  def to_ary
    @field
  end

  def to_table
    table = Terminal::Table.new headings: (0...size).to_a << "x/y", rows: @field, style: { all_separators: true }
    (0...@size).each { |i| table.rows[i] << i }
    table.align_column(size, :center)
    table.to_s
  end

  protected

  attr_accessor :field
end
