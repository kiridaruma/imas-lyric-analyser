result = {}
count = 0

ARGV.each do |word|
    count += 1
    result[word] = 0 if(result[word].nil?)
    result[word] += 1
end

result = result.sort_by do |_, v|
    -v
end

result.each do |k, v|
    puts "#{k} : #{v} \t\t #{v.to_f/count * 100}%"
end

puts count
