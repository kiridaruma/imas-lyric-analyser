result = {}
count = 0

ARGV.each do |filename|
    File.read(filename).split("\n").each do |word|
        count += 1
        result[word] = 0 if(result[word].nil?)
        result[word] += 1
    end
end

result = result.sort_by do |_, v|
    -v
end

result.each do |k, v|
    puts "#{k} : #{v}"
end

puts count
