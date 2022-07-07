require 'pry'

ARR_CLEANER = [',', '.', ';', '\'', '!', '“', '”', '(', ')', '?', ' to ', ' a ', ' is ', ' of ', ' the '].freeze
words_hash = {}

f = File.open('word_counter.txt', 'r')
#f_output = File.open('result_file.txt', 'a')

f.each_line do |line|
  
  ARR_CLEANER.each do |clearn_simbol|
  line.gsub!(clearn_simbol, '')
  end
  line.gsub!(/\s+/, ' ')
  arr = line.split(/\s/)
    arr.each do |word|
      word = word.downcase
        if words_hash.include?(word)
          words_hash[word] += 1
        else
          words_hash[word] = 1
        end
    end
    
end
f.close

hash = words_hash.sort{|a,b| b[1]<=>a[1]}
hash.each do |key, value|
  puts "#{key}---#{value}"
end