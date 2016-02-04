require 'minitest/autorun'
require 'rspec'
class Card
  attr_accessor :suite, :name, :value

  def initialize(suite, name, value)
    @suite, @name, @value = suite, name, value
  end
end

class Deck
  attr_accessor :playable_cards
  SUITES = [:hearts, :diamonds, :spades, :clubs]
  NAME_VALUES = {
    :two   => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 10,
    :queen => 10,
    :king  => 10,
    :ace   => [11, 1]}

  def initialize
    shuffle
  end

  def deal_card
    random = rand(@playable_cards.size)
    @playable_cards.delete_at(random)
  end

  def shuffle
    @playable_cards = []
    SUITES.each do |suite|
      NAME_VALUES.each do |name, value|
        @playable_cards << Card.new(suite, name, value)
      end
    end
  end
end

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def hit(deck)
    @cards << deck.playable_cards.shift
  end

  def value
    value = 0
    cards.each do |card|
      value += card.value
    end
    value
  end

  def show_upcard_value
    @cards[0].value
  end

  def dealers_turn(deck)
    if value < 17 
      hit(deck)
      dealers_turn(deck)
    end
  end
end

class Game
  attr_reader :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Hand.new
    @dealer = Hand.new
    2.times { @player.hit(@deck) }
    2.times { @dealer.hit(@deck) }
  end

  def check_winner(player_value, dealer_value)
    if player_value > 21
      "Busted!"
    elsif dealer_value > 21
      "Dealer busted, you win!"  
    elsif player_value == 21
      "Blackjack!"
    elsif player_value > dealer_value
      "You win!"
    else
      "You lose!"
    end
  end

end




class CardTest < Minitest::Test
  def setup
    @card = Card.new(:hearts, :ten, 10)
  end
  
  def test_card_suite_is_correct
    assert_equal @card.suite, :hearts
  end

  def test_card_name_is_correct
    assert_equal @card.name, :ten
  end
  def test_card_value_is_correct
    assert_equal @card.value, 10
  end
end

class DeckTest < Minitest::Test
  def setup
    @deck = Deck.new
  end
  
  def test_new_deck_has_52_playable_cards
    assert_equal @deck.playable_cards.size, 52
  end
  
  def test_dealt_card_should_not_be_included_in_playable_cards
    check = true
    card = @deck.deal_card
    @deck.playable_cards.each do |cards|
      if cards.suite == card.suite && cards.name == card.name
        check = true
      else
        check = false
      end
    end
    assert_equal @deck.playable_cards.include?(card), false
  end

  def test_shuffled_deck_has_52_playable_cards
    @deck.shuffle
    assert_equal @deck.playable_cards.size, 52
  end
end

class GameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_player_gets_2_cards
    assert_equal @game.player.cards.length, 2
  end

  def test_dealer_gets_2_cards
    assert_equal @game.dealer.cards.length, 2
  end
end

RSpec.describe Hand do

  it "should show dealers hand" do
    deck = double(:deck, :playable_cards => [Card.new(:hearts, :nine, 9), Card.new(:spades, :two, 2)])
    @dealer = Hand.new
    2.times { @dealer.hit(deck) }
    expect(@dealer.show_upcard_value).to eq(@dealer.cards[0].value)
  end

  it "should bust when players goes over 21" do
    game = Game.new
    expect(game.check_winner(23,13)).to eq("Busted!")
  end

  it "should allow user to blackjack if cards equal 21" do
    game = Game.new
    expect(game.check_winner(21,20)).to eq("Blackjack!")
  end

  it "should allow dealer to get cards after player stands" do
    deck = double(:deck, :playable_cards => [Card.new(:hearts, :nine, 9), Card.new(:spades, :two, 2), Card.new(:clubs, :nine, 9), Card.new(:diamonds, :three, 3)])
    dealer_hand = Hand.new
    2.times { dealer_hand.hit(deck) }
    dealer_hand.dealers_turn(deck)
    expect(dealer_hand.value).to eq(20)
  end
end