require_relative 'command'

class D6Command < Command
    def initialize
        super(name: "d6", description: "Rolls a d6")
    end

    def execute(event)
        event.respond("You rolled: #{rand(1..6)}")
    end
end