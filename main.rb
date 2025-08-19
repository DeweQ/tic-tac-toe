require_relative "lib/tic_tac_toe"

loop do
  puts "=" * 80
  puts "NEW GAME"
  game = TicTacToe.new
  until game.finished?
    puts game.current_player == "X" ? "It's Crosses turn: " : "It's Noughts turn"
    game.print_field
    puts "Enter coordinates separated by space (ex. '0 0')"
    coords = gets.split.map do |s|
      Integer(s)
    rescue ArgumentError
      nil
    end
    puts "Invalid coordinates" if game.mark_field(coords[0], coords[1]) == "Invalid coordinates"
    puts "*" * 80
  end
  winner = game.check_winner
  if winner == "None"
    puts "Game ended in a draw!"
  else
    puts "Game finished! #{game.check_winner == 'X' ? 'Crosses' : 'Noughts'} wins!"
  end
  puts "Press Ctrl+C to exits"
end
