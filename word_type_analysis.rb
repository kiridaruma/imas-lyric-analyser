require 'cabocha'
require __dir__+'/lib/song.rb'
require __dir__+'/lib/tree.rb'

ARGV.each do |filename|
    txt = File.new(filename).read
    song = Song.new(txt)
    STDERR.puts song.title
    parser = CaboCha::Parser.new
    trees = song.lyric.split("\n").map do |line|
        str = parser.parse(line).toString(CaboCha::FORMAT_LATTICE).force_encoding("UTF-8")
        Tree.new(str)
    end

    trees.each do |tree|
        tree.chunks.each do |chunk|
            target_wordtype_tokens = chunk.tokens.select do |token|
                # 抽出したい品詞の条件
            end
            target_wordtype_tokens.each do |token|
                puts token.word
            end
        end
    end
end