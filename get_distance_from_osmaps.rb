require 'geocoder'
require 'faraday'
require 'oj'
results = Geocoder.search("Дзержинск")
first_point = results.first.coordinates
results = Geocoder.search("Краснодар")
second_point = results.first.coordinates

path = "http://router.project-osrm.org/trip/v1/driving/#{first_point[1]},#{first_point[0]};#{second_point[1]},#{second_point[0]}?overview=false"

response = Faraday.get(path)
response = Oj.load(response.body).fetch('trips').fetch(0).fetch('legs').fetch(0).fetch('distance')
puts response
