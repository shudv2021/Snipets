require 'pry'

class Storrage
  
attr_accessor :storrage

def initialize
@storrage = []
end

def seed
@storrage = [
  {quantiti: 30, name: 'Botle', capacity: 30}, 
  {quantiti: 30, name: 'Botle', capacity: 15},
  {quantiti: 30, name: 'Glass', capacity: 30},
  {quantiti: 30, name: 'Glass', capacity: 30},
  {quantiti: 30, name: 'Botle', capacity: 19},
  {quantiti: 30, name: 'Botle', capacity: 30}
]  
end

def show_list
  @storrage.each do |storage_object|
    
    filled = ''
    storage_object.fetch(:quantiti) == storage_object.fetch(:capacity) ? filled = "filled" : filled = ""
    puts "#{storage_object.fetch(:quantiti)}|#{storage_object.fetch(:name)}|#{filled}"
  end
end

def add_product
product = self.requet_product
@storrage << product
end


private


def requet_product
product = {}
print "input product name:"
product[:name] = gets.chomp
print 'input quantiti:'
product[:quantiti] = gets.chomp.to_i

product
end

def surplus(quantiti, capacity)
quantiti - capacity
end

end



str = Storrage.new
str.seed
puts str.show_list

str.add_product

puts str.show_list