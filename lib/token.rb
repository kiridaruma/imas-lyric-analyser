
class Token
    def initialize(original, feature)
        @original = original

        list = feature.strip.split(',')
        @type = list[0..6].map do |t|
            if(t == '*')
                nil
            else
                t
            end
        end

        @word = list[6] == '*' ? @original : list[6]
        @normalized_word = list[7]
        @pronounce = list[8]
    end

    attr_reader :original, :type, :word, :normalized_word, :pronounce
end
