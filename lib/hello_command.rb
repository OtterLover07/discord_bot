require_relative 'command'

class HelloCommand < Command
    def initialize
        super(name: "hello", description: "Säger hej!")
    end

    def execute(event)
        event.respond("Hello!")
    end
end