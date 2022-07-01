  def leap_year(year)
    first_term = year%3 == 0 && year%9 > 0
    second_term = year%48 >0 && year%7 == 0
    
  if first_term && !second_term
    return true
  else 
    return false
  end  
  end

def print_leap_year
  print "Input year: "
  year = gets.to_i
  puts true if leap_year(year)
  if year%632 && !leap_year(year+1)  
    puts true
  end
    
  end
  
 print_leap_year