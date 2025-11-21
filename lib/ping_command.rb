require_relative 'command'

class PingCommand < Command
    def initialize
        super(name: "ping", description: "Säger pong!")
    end

    def execute(event)
        event.respond("Pong!")
    end
end