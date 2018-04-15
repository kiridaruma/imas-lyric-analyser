require __dir__+"/chunk.rb"
require __dir__+"/token.rb"

class Tree
    def initialize(txt)
        @chunks = []
        @links = []

        # 与えられた文字列をparseでチャンク意味ごとに分解
        parse(txt.strip).each do |str|

            lines = str.split("\n")

            # token文字列のリストはEOSを含むかもしれないので、filter
            tokenLines = lines[1..lines.length].select do |tokenLine|
                tokenLine != 'EOS'
            end

            tokens = buildTokens(tokenLines)
            buildChunk(lines[0], tokens[0..tokens.length - 1])
        end
    end

    # CaboChaの出力文字列をチャンク意味ごとに区切る
    private def parse(txt)
        txt.split("\n").reduce([]) do |acc, line|
            if(line[0] == '*' && !line.include?("\t"))
                acc << line + "\n"
            elsif(line.include?("\t"))
                acc[acc.length - 1] << line + "\n"
            end
            acc
        end
    end

    # Tokenリストとチャンク文字列を取って@chunksと@linksを生成する
    private def buildChunk(str, tokens)
        list = str.split(" ")
        head_pos = list[3].split('/')[0].to_i
        @chunks << Chunk.new(tokens, head_pos)
        @links << list[2].delete('D').to_i
    end

    # token行のリストを受け取って、Tokenのリストを返す
    private def buildTokens(lines)
        lines.map do |line|
            arr = line.split("\t")
            Token.new(arr[0].strip, arr[1].strip)
        end
    end

    attr_reader :chunks, :links
end