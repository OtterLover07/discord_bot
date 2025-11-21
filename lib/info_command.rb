require_relative 'command'

class InfoCommand < Command
    def initialize
        super(name: "info", description: "Ger botinformation")
    end

    def execute(event)
        event.respond("OtterBot v0.1 - Currently building functionality")
    end
end