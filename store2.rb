require 'pry'

class Storrage

attr_accessor :storrage

def initialize
  @storrage = []
end

def seed
  example_storrage = [
    {quantity: "30", name: 'Botle', capacity: "30"}, 
    {quantity: "15", name: 'Botle', capacity: "30"},
    {quantity: "30", name: 'Glass', capacity: "30"},
    {quantity: "15", name: 'Glass', capacity: "30"},
    {quantity: "19", name: 'Botle', capacity: "30"},
    {quantity: "30", name: 'Botle', capacity: "30"}
  ]
  example_storrage.each do |product|
    pr = Product.new
    pr.attributes = product
    @storrage << pr
  end
end

def show
  
  @storrage.each_with_index do |product, index|
    stat = ''
    if product.attributes[:quantity].to_i == product.attributes[:capacity].to_i
    stat = 'fill'
    end
  puts "#{index + 1} | #{product.attributes[:name]} | #{product.attributes[:quantity]} | #{stat}"
  end
end


def put(product)
similar_product = product.find_similar_freespace(self)
  if similar_product.empty?
    self.create_new(product)
  else
    self.reload(@storrage[similar_product[0]], product)
  end
end


private

def reload(place, product)
  freespace = place.attributes[:capacity].to_i - place.attributes[:quantity].to_i
  if freespace >= product.attributes[:quantity].to_i
    place.attributes[:quantity] = (place.attributes[:quantity].to_i + product.attributes[:quantity].to_i).to_s
    product.attributes[:quantity] = '0'
  else
    place.attributes[:quantity] = place.attributes[:capacity]
    product.attributes[:quantity] = (product.attributes[:quantity].to_i - freespace).to_s
    self.put(product)
  end
  self.show
end

def create_new(product)
  @storrage << product if product.attributes[:quantity].to_i > 0
  self.show
end
  
end

class Product
  
  attr_accessor :attributes
  
def initialize
  @attributes = {:name => 'Botle', :quantity => '10', :capacity => '30'}
  
end

def fill
    @attributes.each_key do |key|
    print "Set product #{key} :"
    @attributes[key] = gets.chomp
    end
  self.correct_attributes?
    
end


def find_similar_freespace(storrage)
  similar = []
  storrage.storrage.each_with_index do |product, index|
  condition1 = product.attributes[:name] == self.attributes[:name]
  contition2 = product.attributes[:quantity] < product.attributes[:capacity]
    if condition1 && contition2
      similar << index
    end
end
  similar
end

private

def correct_attributes?
  if @attributes[:quantity].to_i > @attributes[:capacity].to_i
  puts "Divide on several position"
  self.fill
  end
end

end

str = Storrage.new
str.seed

loop do
pr = Product.new
pr.fill
str.put(pr)
end

