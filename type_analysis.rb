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
                # token.type[0] == "名詞" && (
                #     token.type[1] == "サ変接続" ||
                #     token.type[1] == "形容動詞語幹" ||
                #     token.type[1] == "副詞可能" ||
                #     token.type[1] == "接尾" ||
                #     token.type[1] == "代名詞"
                # )
                # token.type[0] == "動詞" && token.type[1] == "自立"
                # token.type[0] == "形容詞" && token.type[1] == "自立"
                # token.type[0] == "感動詞"
            end
            target_wordtype_tokens.each do |token|
                puts token.word if !token.word.match(/^[0-9!-\/:-@\[-`{-~]+$/)
            end
        end
    end
end