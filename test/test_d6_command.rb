require_relative 'spec_helper'
require_relative '../lib/d6_command'

class TestD6Command < Minitest::Test
  def test_dice_command_has_name_and_description
    command = D6Command.new

    assert_equal "d6", command.name
    assert_equal "Rolls a d6", command.desc
  end

  def test_dice_returns_number_between_1_and_6
    command = D6Command.new
  
    # Kör 100 gånger för att verifiera range
    100.times do
      mock_event = MockEvent.new(content: "!dice")
      command.execute(mock_event)
  
      # Extrahera nummer från svaret (t.ex. "Du rullade: 4")
      response = mock_event.responses.first
      number = response.match(/\d+/)[0].to_i
  
      assert_includes 1..6, number
    end
  end
end