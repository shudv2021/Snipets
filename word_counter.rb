require 'pry'
f = File.open('word_counter.txt', 'r')
f_output = File.open('result_file.txt', 'a')

f.each_line do |line|
  arr_cleaner = [',', '.', ';', '\'', '!']
  arr_cleaner.each do |clearn_simbol|
  line.gsub!(clearn_simbol, '')
  end
  line.gsub!(/\s+/, ' ')
  arr = line.split(/\s/)
    arr.each do |word|
    f_output.puts(word)
    end
    
end

f.close
f_output.close
