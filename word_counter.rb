
f = File.open('word_counter.txt', 'r')

f.each_line do |line|
  
  line.gsub!(/\s|\n|,|\.|!/)
  puts line.split(/ /)
end

f.close