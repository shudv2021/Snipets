arr = [1, 3, 4, 8, 14, 15]

arr1 = arr.each { |obj| obj+1 }
puts '***************'
print arr
print arr1
puts '***************'
arr2 = arr.map { |obj| obj+1 }
print arr
print arr2
puts '***************'
arr3 = arr.map! { |obj| obj+1 }
print arr
print arr2