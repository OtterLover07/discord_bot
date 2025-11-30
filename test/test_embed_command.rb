require_relative 'spec_helper'
require_relative '../lib/embed_command'
require_relative '../lib/command'

class TestEmbedCommand < Minitest::Test
  def test_embed_command_can_be_created
    command = EmbedCommand.new(
      name: "info",
      description: "Shows bot info",
      title: "Bot Info",
      embed_description: "A cool bot",
      color: 0x00ff00
    )

    assert_instance_of EmbedCommand, command
    assert_kind_of Command, command
    assert_equal "info", command.name
    assert_equal "Bot Info", command.title
  end
  def test_embed_command_sends_embed
      command = EmbedCommand.new(
        name: "info",
        description: "Shows info",
        title: "Bot Information",
        embed_description: "A cool Ruby bot",
        color: 0x00ff00
      )
      mock_event = MockEvent.new

      command.execute(mock_event)

      # Verifiera att ett embed skickades
      assert_equal 1, mock_event.channel.embeds.length

      # Verifiera embed-innehåll
      embed = mock_event.channel.embeds.first
      assert_equal "Bot Information", embed.title
      assert_equal "A cool Ruby bot", embed.description
      assert_equal 0x00ff00, embed.color
  end
  
  def test_embed_command_supports_fields
    command = EmbedCommand.new(
      name: "serverinfo",
      description: "Server info",
      title: "Server Information",
      embed_description: "Info about this server",
      color: 0x0099ff,
      fields: [
        { name: "Members", value: "42" },
        { name: "Created", value: "2024-01-01" }
      ]
    )
    mock_event = MockEvent.new

    command.execute(mock_event)


    embed = mock_event.channel.embeds.first
      assert_equal [{ name: "Members", value: "42" },
        { name: "Created", value: "2024-01-01" }], embed.fields
  end
end