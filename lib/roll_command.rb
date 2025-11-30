require_relative 'command'

class RollCommand < Command
    def initialize
        super(name: "roll", description: "Roll dice (e.g. !roll d20, !roll 2d6)")
    end

    def execute(event, args = [])
        notation = if args[0] == nil
           "d6"
        else
            args[0]
        end
        match = notation.match(/^(\d+)?d(\d+)$/i)

        if match
          count = match[1] ? match[1].to_i : 1  # Default 1 om inget nummer
          sides = match[2].to_i
          # count = 2, sides = 6
        else
            event.respond("Bad format! Use: !roll d20 or !roll 2d6")
            return nil
        end

        results = count.times.map { rand(1..sides) }
        total = results.sum

        event.respond("Rolled #{count}d#{sides}: #{results.join(', ')} = **#{total}**")
    end
end