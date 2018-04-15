require __dir__+'/token.rb'

class Chunk

    def initialize(tokens, head_pos)
        @tokens = tokens
        @head = tokens[head_pos]
    end

    def to_str
        @tokens.reduce("") do |acc, token|
            acc << token.original
        end
    end

    attr_reader :tokens, :head
end