require 'pry'
require 'geocoder'
require 'faraday'
require 'oj'

class Transit
  
  TRANSIT_CATEGORYES = {:small=>1.0, :big_light=>2.0, :big_heavy=>3.0}
  
  attr_accessor :receive_params
  
  def initialize
    @receive_params = { cargo: {weight: 0, length: 0, width: 0, height: 0}, route: {point_of_departure: "", destination: "", distance: 0}, price: 0}
  end
  

  def get_compile_params
  result_hash = {}
  self.set_cargo_params; self.set_route_params; self.calc_distance; self.calc_price

  self.receive_params.fetch(:cargo).each do |params|
    result_hash[params[0]] = params[1]
  end
  result_hash[:distance] = self.receive_params.fetch(:route).fetch(:distance)
  result_hash[:price] = self.receive_params.fetch(:price)
  
  return result_hash
  end

  
  private

  def set_cargo_params
    self.receive_params.fetch(:cargo).each_key do |cargo_params|
      print "Input #{cargo_params} : "
      self.receive_params.fetch(:cargo)[cargo_params] = gets.chomp.to_f
    end  
  end
  
  def set_route_params
  self.receive_params.fetch(:route).each_key do |rout_params|
    unless rout_params == :distance
      print "Input #{rout_params} : "
      self.receive_params.fetch(:route)[rout_params] = gets.chomp
    end
  end
  end
  
  def calc_price
    volume ||= 1
    weight = 0
    self.receive_params.fetch(:cargo).each_key do |params|  
    unless params == :weight
    volume = volume * self.receive_params.fetch(:cargo)[params] /100.0
    else
    weight = self.receive_params.fetch(:cargo)[params]
    end
    category = :small
    if volume > 1.0 && weight <= 10
      category = :big_light
    elsif  volume > 1.0 && weight > 10
      category = :big_heavy
    end
    self.receive_params[:price] = self.receive_params.fetch(:route).fetch(:distance) * TRANSIT_CATEGORYES[category]
    end
  end
  
  def calc_distance
    results = Geocoder.search(self.receive_params.fetch(:route).fetch(:point_of_departure))
    first_point = results.first.coordinates
    results = Geocoder.search(self.receive_params.fetch(:route).fetch(:destination))
    second_point = results.first.coordinates
    
    path = "http://router.project-osrm.org/trip/v1/driving/#{first_point[1]},#{first_point[0]};#{second_point[1]},#{second_point[0]}?overview=false"
    response = Faraday.get(path)
    response = Oj.load(response.body).fetch('trips').fetch(0).fetch('legs').fetch(0).fetch('distance') 
    self.receive_params[:route][:distance] = (response/1000).round(0)
  end
  
end

transit = Transit.new
puts transit.get_compile_params