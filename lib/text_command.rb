require_relative 'command'

class TextCommand < Command
    attr_reader :text

    def initialize(
        name: "test",
        description: "Test command",
        text: "Test response"
    )
        super(name: name, description: description)
        @text = text
    end

    def execute(event)
        event.respond(@text)
    end
end