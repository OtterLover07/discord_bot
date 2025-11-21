class Command
    attr_reader :name, :desc

    def initialize(name:, description: "")
        @name = name
        @desc = description
    end

    def execute(event)
        raise NotImplementedError, "Subclass must implement execute method" #NYTT
    end
end