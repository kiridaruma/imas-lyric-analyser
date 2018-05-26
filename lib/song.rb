
class Song
    def initialize(str)
        lines = str.split("\n").map do |line| line.strip end
        raise ArgumentError if(lines.length < 5)
        @title = lines[0]
        @singer = lines[2]

        @lyric = lines[4..-1].reduce do |txt, line|
            if(line != '')
                txt << "\n"+line
            end
            txt
        end
    end

    attr_accessor :title, :singer, :lyric

    def export
        txt = "#{@title}\n\n#{@singer}\n\n#{@lyric}"
    end

end