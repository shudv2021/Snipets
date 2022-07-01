str_1 = 'This is string'
str_2 = str_1.split('t')
# arr_1 = str_1.to_a
puts str_2
puts str_2.class

arr = [[1, 2], [3, 4], [5, '6']]
hash = arr.to_h
puts hash.inspect

arr2 = [1, 2, 3, :a, 5, 6, 7, 8]
hash2 ={}
arr2.each_index do |i|
hash2[arr2[i]] = arr2[i+1] if i%2 == 0
end
puts hash2.inspect