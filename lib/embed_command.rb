require_relative 'command'

class EmbedCommand < Command
    attr_reader :title, :description, :color

    def initialize(
        name: "test",
        description: "Test command",
        title: "Example title",
        embed_description: "Example embed",
        color: "Test response",
        fields: []
    )
        super(name: name, description: description)
        @title = title
        @description = embed_description
        @color = color
        @fields = fields
    end

    def execute(event)
        event.channel.send_embed do |embed|
            embed.title = @title
            embed.description = @description
            embed.color = @color
            embed.fields = @fields
        end
    end
end