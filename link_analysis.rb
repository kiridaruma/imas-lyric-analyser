require 'cabocha'
require __dir__+'/lib/idol.rb'
require __dir__+'/lib/song.rb'
require __dir__+'/lib/tree.rb'

ARGV.each do |filename|
    txt = File.new(filename).read
    song = Song.new(txt)


    # series変数でどのシリーズの曲か判別
    # 765PRO ALLSTARS = 0
    # CINDERELLA GIRLS = 1
    # 765 MILLIONSTARS = 2
    # 315 STARS = 3
    # Other = 4
    idol = Idol.new()
    serieses = [0,1,2,3,4]
    song_seriese = idol.checkSongAffiliation(song)
    if !serieses.include?(song_seriese) then
        next
    end

    STDERR.puts song.title
    parser = CaboCha::Parser.new
    trees = song.lyric.split("\n").map do |line|
        str = parser.parse(line).toString(CaboCha::FORMAT_LATTICE).force_encoding("UTF-8")
        Tree.new(str)
    end

    trees.each do |tree|
        head_tokens = tree.chunks.map do |chunk|
            chunk.head
        end

        # 抽出したい単語のリスト
        target_words = []

        idx = head_tokens.index do |token|
            target_words.any? do |target|
                token.word == target
            end
        end
        next if(!idx)

        # 係り受け先探索
        to_idx = tree.links[idx]
        if(to_idx != -1) then
            puts head_tokens[to_idx].word if !token.word.match(/^[0-9!-\/:-@\[-`{-~]+$/)
        end
        # 係り受け元探索
        from_idx = tree.links.index(idx)
        if(!from_idx.nil?) then
            puts head_tokens[from_idx].word  if !token.word.match(/^[0-9!-\/:-@\[-`{-~]+$/)
        end
    end
end