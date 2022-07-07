(1..100).each do |num|
  marker = ''
  marker +='Fizz' if num%3 == 0
  marker +='Buzz' if num%5 == 0
  puts "#{num} -- #{marker}" 
end