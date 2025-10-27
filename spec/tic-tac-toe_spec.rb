require_relative "../lib/tic_tac_toe"

describe TicTacToe do
  describe "#initialize" do 
   # subject(:game_init) { described_class.new(3) }
    context "when game initialized" do
      it "sends message #new to Field" do
        expect(Field).to receive(:new)
        TicTacToe.new()
      end
    end
  end
  describe "#mark_field" do
    let(:field_class) {class_double("Field")}
    let(:unaccessible_coord) {-1}
    let(:field) { instance_double("Field") }
    subject(:stubbed_game) { described_class.new}

    context "when given unaccessible coordinates" do
      before do
        stub_const("Field", field_class)
        allow(field_class).to receive(:new).and_return(field)
        allow(field).to receive(:accessible?).and_return(false)
      end
      it "send accessible?" do
        expect(field).to receive(:accessible?).and_return(false)
       stubbed_game.mark_field(unaccessible_coord,unaccessible_coord)
      end

      it "does not change current player" do
        expect {stubbed_game.mark_field(unaccessible_coord,unaccessible_coord)}.to_not change(stubbed_game, :current_player)
      end

      it "does not send add_mark" do
        expect(field).to_not receive(:add_mark)
        stubbed_game.mark_field(unaccessible_coord,unaccessible_coord)
      end
    end

    context "when given accessible coordinates" do
      before do
        stub_const("Field", field_class)        
        allow(field_class).to receive(:new).and_return(field)
        allow(field).to receive(:accessible?).and_return(true)
        allow(field).to receive(:add_mark)
      end
      
      it "send accessible?" do
        expect(field).to receive(:accessible?).and_return(true)
        stubbed_game.mark_field(0, 0)
      end

      it "send add_mark" do
        expect(field).to receive(:add_mark)
        stubbed_game.mark_field(0,0)
      end

      it "change current_player" do
        expect {stubbed_game.mark_field(0,0)}.to change(stubbed_game, :current_player)
      end
    end
  end

  describe "#check_winner" do 
    context "when game has no winner" do
    subject(:nowinner_game) {described_class.new}
      it "returns nil" do
        expect(nowinner_game.check_winner).to be_nil
      end
    end
    
    context "when game has winner in row" do
      subject(:row_game) {described_class.new}
      before do
        field = row_game.instance_variable_get(:@field)
        field.add_mark("X",0,0)
        field.add_mark("X",0,1)
        field.add_mark("X",0,2)
      end
      it "returns winner's mark" do
        expect(row_game.check_winner).to eq("X")
      end
    end

    context "when game has winner in column" do
      subject(:column_game) {described_class.new}
      before do
        field = column_game.instance_variable_get(:@field)
        field.add_mark("O",0,1)
        field.add_mark("O",1,1)
        field.add_mark("O",2,1)
      end
      it "returns winner's mark" do
        expect(column_game.check_winner).to eq("O")
      end
    end

    context "when game has winner in diagonal" do
      subject(:diagonal_game) {described_class.new}
      before do
        field = diagonal_game.instance_variable_get(:@field)
        field.add_mark("X",0,0)
        field.add_mark("X",1,1)
        field.add_mark("X",2,2)
      end
      it "returns winner's mark" do
        expect(diagonal_game.check_winner).to eq("X")
      end
    end
  end

  describe "#finished?" do end
end
